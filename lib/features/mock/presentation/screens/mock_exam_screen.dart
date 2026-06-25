import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';

import '../../../practice/data/datasources/local_question_loader.dart';
import '../../../practice/data/models/question_model.dart';
import '../../../practice/domain/services/adaptive_practice_service.dart';

import '../../domain/services/mock_session_controller.dart';
import '../../../practice/presentation/widgets/practice_answer_option_tile.dart';
import '../widgets/mock_action_button.dart';

class MockExamScreen extends StatefulWidget {
  const MockExamScreen({super.key});

  @override
  State<MockExamScreen> createState() => _MockExamScreenState();
}

class _MockExamScreenState extends State<MockExamScreen> {
  final _loader = LocalQuestionLoader();
  final _adaptiveService = AdaptivePracticeService();
  final _session = MockSessionController.instance;

  Timer? _timer;
  bool _loading = true;
  String? _error;

  QuestionModel get _question => _session.currentQuestion;

  @override
  void initState() {
    super.initState();
    _initializeMockExam();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeMockExam() async {
    try {
      if (_session.initialized && _session.questions.isNotEmpty) {
        setState(() => _loading = false);

        _startTimer();
        return;
      }

      final questions = await _loader.loadQuestions();

      if (!mounted) return;

      final config = _session.buildConfiguration();

      _session.applyPreferences();

      _session.questions = _adaptiveService.generateSession(
        questions,
        sessionSize: config.questionCount,
      );

      _session.currentIndex = 0;
      _session.initialized = true;
      _session.startSession();

      setState(() {
        _loading = false;
      });

      _startTimer();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = 'Unable to load mock exam.';
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      if (_session.remainingTime.inSeconds <= 0) {
        _timer?.cancel();

        Navigator.pushReplacementNamed(context, RouteNames.mockSummary);

        return;
      }

      setState(() {
        _session.remainingTime =
            _session.remainingTime - const Duration(seconds: 1);
      });
    });
  }

  void _selectAnswer(String option) {
    setState(() {
      _session.selectAnswer(option);
    });
  }

  void _toggleFlag() {
    setState(() {
      _session.toggleFlag();
    });
  }

  void _next() {
    if (_session.currentIndex >= _session.questions.length - 1) {
      Navigator.pushReplacementNamed(context, RouteNames.mockSummary);
      return;
    }

    setState(() {
      _session.moveNext();
    });
  }

  void _openReview() {
    Navigator.pushNamed(
      context,
      RouteNames.review,
      arguments: _session.buildReviewData(),
    );
  }

  Color _timerColor() {
    final minutes = _session.remainingTime.inMinutes;

    if (minutes <= 5) {
      return Colors.red;
    }

    if (minutes <= 10) {
      return Colors.orange;
    }

    return Colors.green;
  }

  String _formattedTime() {
    final minutes = _session.remainingTime.inMinutes;
    final seconds = _session.remainingTime.inSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading) {
      return Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(title: const Text('Mock Exam')),
        body: Center(child: Text(_error!)),
      );
    }

    final timerColor = _timerColor();

    final selectedAnswer = _session.selectedAnswerFor(_question.id);

    final isFlagged = _session.isFlagged(_question.id);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: const Text('Mock Exam'),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: timerColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: timerColor.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 42, color: timerColor),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Time left', style: theme.textTheme.bodyMedium),

                          Text(
                            _formattedTime(),
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: timerColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Questions', style: theme.textTheme.bodyMedium),

                        Text(
                          '${_session.currentIndex + 1}'
                          ' / ${_session.totalQuestions}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _question.question,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 18),

                      if (_question.image != null)
                        Center(
                          child: Image.asset(
                            _question.image!,
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),

                      const SizedBox(height: 20),

                      ..._question.options.entries.map((entry) {
                        return PracticeAnswerOptionTile(
                          optionKey: entry.key,
                          optionText: entry.value,
                          selectedAnswer: selectedAnswer,
                          correctAnswer: _question.correctAnswer,
                          showResult: false,
                          onTap: () {
                            _selectAnswer(entry.key);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 400;

                  return Row(
                    children: [
                      Expanded(
                        child: compact
                            ? MockActionButton(
                                icon: isFlagged
                                    ? Icons.flag
                                    : Icons.outlined_flag,
                                label: isFlagged ? 'Flagged' : 'Flag',
                                color: isFlagged ? Colors.orange : null,
                                onPressed: _toggleFlag,
                              )
                            : OutlinedButton.icon(
                                onPressed: _toggleFlag,
                                icon: Icon(
                                  isFlagged ? Icons.flag : Icons.outlined_flag,
                                  color: isFlagged ? Colors.orange : null,
                                ),
                                label: Text(isFlagged ? 'Flagged' : 'Flag'),
                              ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: compact
                            ? MockActionButton(
                                icon: Icons.visibility,
                                label: 'Review',
                                onPressed: _openReview,
                              )
                            : OutlinedButton.icon(
                                onPressed: _openReview,
                                icon: const Icon(Icons.visibility),
                                label: const Text('Review'),
                              ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        flex: 2,
                        child: FilledButton.icon(
                          onPressed: selectedAnswer == null ? null : _next,
                          icon: const Icon(Icons.chevron_right),
                          label: Text(
                            _session.currentIndex == _session.totalQuestions - 1
                                ? 'Finish'
                                : 'Next',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
