import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../../../progress/domain/services/progress_engine.dart';
import '../../data/datasources/local_question_loader.dart';
import '../../data/models/question_model.dart';
import '../../domain/services/practice_session_controller.dart';
import '../../domain/services/adaptive_practice_service.dart';
import '../widgets/practice_answer_option_tile.dart';
import '../widgets/practice_explanation_card.dart';
import '../widgets/practice_progress_card.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../profile/domain/services/study_preferences_controller.dart';
import '../../../profile/data/models/study_preferences.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final _loader = LocalQuestionLoader();
  final _engine = ProgressEngine();
  final _uuid = const Uuid();
  final _stopwatch = Stopwatch();

  final _session = PracticeSessionController.instance;
  final _adaptiveService = AdaptivePracticeService();

  bool _loading = true;
  String? _error;

  QuestionModel get _question => _session.questions[_session.currentIndex];

  String? get _selectedAnswer => _session.selectedAnswers[_question.id];

  bool get _showResult => _session.answeredQuestions[_question.id] ?? false;
  Timer? _autoAdvanceTimer;

  @override
  void initState() {
    super.initState();
    _initializePracticeSession();
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  Future<void> _initializePracticeSession() async {
    try {
      if (_session.inProgress && _session.questions.isNotEmpty) {
        if (!mounted) return;

        setState(() => _loading = false);

        if (!_showResult) _restartTimer();
        return;
      }

      final data = await _loader.loadQuestions();

      if (!mounted) return;

      final selectedCategory =
          ModalRoute.of(context)?.settings.arguments as String?;

      final prefs = StudyPreferencesController.instance.preferences;
      final questionCount = prefs.practiceQuestionCount;

      final selectedQuestions = selectedCategory == null
          ? _adaptiveService.generateSession(data, sessionSize: questionCount)
          : data
                .where(
                  (question) =>
                      question.category.toLowerCase() ==
                      selectedCategory.toLowerCase(),
                )
                .toList();

      if (prefs.randomizeQuestions) {
        selectedQuestions.shuffle();
      }

      switch (prefs.questionMode) {
        case QuestionMode.multipleChoice:
          break;

        case QuestionMode.mixed:
          break;
      }

      _session.questions = selectedQuestions.take(questionCount).toList();
      _session.currentIndex = 0;
      _session.selectedAnswers.clear();
      _session.answeredQuestions.clear();
      _session.initialized = true;

      _session.startSession();

      setState(() => _loading = false);

      if (prefs.practiceTimerEnabled) {
        _restartTimer();
      }
    } catch (e, stackTrace) {
      debugPrint('Question loading failed: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = 'Unable to load practice questions.';
      });
    }
  }

  void _restartTimer() {
    if (_showResult) return;

    _stopwatch
      ..reset()
      ..start();
  }

  void _selectAnswer(String key) {
    if (_showResult) return;

    setState(() {
      _session.selectedAnswers[_question.id] = key;
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer == null || _showResult) return;

    _stopwatch.stop();

    final isCorrect = _selectedAnswer == _question.correctAnswer;
    final prefs = StudyPreferencesController.instance.preferences;

    _engine.recordAttempt({
      'id': _uuid.v4(),
      'questionId': _question.id,
      'category': _question.category,
      'selectedAnswer': _selectedAnswer,
      'correctAnswer': _question.correctAnswer,
      'isCorrect': isCorrect,
      'timeTaken': prefs.practiceTimerEnabled
          ? _stopwatch.elapsed.inSeconds
          : 0,
      'date': DateTime.now(),
      'testType': 'practice',
    });

    setState(() {
      _session.answeredQuestions[_question.id] = true;
      _session.questionResults[_question.id] = isCorrect;
    });

    if (prefs.autoAdvance && _selectedAnswer != null) {
      _autoAdvanceTimer?.cancel();

      _autoAdvanceTimer = Timer(const Duration(seconds: 2), () {
        if (mounted) {
          _next();
        }
      });
    }
  }

  void _previous() {
    if (_session.currentIndex == 0) return;

    setState(() {
      _session.currentIndex--;
    });

    final prefs = StudyPreferencesController.instance.preferences;
    if (!_showResult && prefs.practiceTimerEnabled) _restartTimer();
  }

  void _next() {
    final prefs = StudyPreferencesController.instance.preferences;

    if (_session.currentIndex >= _session.questions.length - 1) {
      final reviewData = _session.buildReviewData();

      _autoAdvanceTimer?.cancel();
      _stopwatch.stop();

      _session.finishSession();

      Navigator.pushReplacementNamed(
        context,
        RouteNames.review,
        arguments: reviewData,
      );
      return;
    }

    setState(() {
      _session.currentIndex++;
    });

    if (!_showResult && prefs.practiceTimerEnabled) {
      _restartTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading) {
      return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _session.questions.isEmpty) {
      return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          title: const Text('Practice Question'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            _error ?? 'No practice questions available.',
            style: theme.textTheme.bodyLarge,
          ),
        ),
      );
    }

    final progress = (_session.currentIndex + 1) / _session.questions.length;
    final isLastQuestion =
        _session.currentIndex == _session.questions.length - 1;
    final prefs = StudyPreferencesController.instance.preferences;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        title: Text(
          'Practice Question',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PracticeProgressCard(
                      currentQuestion: _session.currentIndex + 1,
                      totalQuestions: _session.questions.length,
                      progress: progress,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      _question.question,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (_question.image != null)
                      Center(
                        child: Image.asset(
                          _question.image!,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    const SizedBox(height: AppSpacing.md),
                    ..._question.options.entries.map(
                      (entry) => PracticeAnswerOptionTile(
                        optionKey: entry.key,
                        optionText: entry.value,
                        selectedAnswer: _selectedAnswer,
                        correctAnswer: _question.correctAnswer,
                        showResult: _showResult,
                        onTap: () => _selectAnswer(entry.key),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (_showResult &&
                        prefs.explanationMode ==
                            ExplanationMode.afterEveryAnswer)
                      PracticeExplanationCard(
                        isCorrect: _selectedAnswer == _question.correctAnswer,
                        explanation: _safeExplanation(_question),
                        source: _safeSource(_question),
                        imagePath: _question.image,
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _session.currentIndex > 0 ? _previous : null,
                      icon: const Icon(Icons.chevron_left),
                      label: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _selectedAnswer == null
                          ? null
                          : _showResult
                          ? _next
                          : _submitAnswer,
                      icon: const Icon(Icons.chevron_right),
                      label: Text(
                        _showResult
                            ? isLastQuestion
                                  ? 'Finish'
                                  : 'Next'
                            : 'Submit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _safeExplanation(QuestionModel question) {
    return question.explanation.trim().isNotEmpty
        ? question.explanation
        : 'Explanation unavailable.';
  }

  String _safeSource(QuestionModel question) {
    return question.source?.trim().isNotEmpty == true
        ? question.source!
        : 'Official DVL Theory Material';
  }
}
