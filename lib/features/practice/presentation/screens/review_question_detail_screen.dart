import 'package:flutter/material.dart';

import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../../data/models/review_question_arguments.dart';
import '../../domain/services/practice_session_controller.dart';
import '../widgets/review_explanation_card.dart';
import '../widgets/review_option_tile.dart';
import '../widgets/review_status_badge.dart';

class ReviewQuestionDetailScreen extends StatefulWidget {
  final ReviewQuestionArguments args;

  const ReviewQuestionDetailScreen({super.key, required this.args});

  @override
  State<ReviewQuestionDetailScreen> createState() =>
      _ReviewQuestionDetailScreenState();
}

class _ReviewQuestionDetailScreenState
    extends State<ReviewQuestionDetailScreen> {
  late int _index;

  List<ReviewQuestionData> get _items => widget.args.questions;

  ReviewQuestionData get _data => _items[_index];

  bool get _canGoPrevious => _index > 0;

  bool get _canGoNext => _index < _items.length - 1;

  @override
  void initState() {
    super.initState();
    _index = widget.args.initialIndex.clamp(
      0,
      widget.args.questions.length - 1,
    );
  }

  void _goPrevious() {
    if (!_canGoPrevious) return;

    setState(() {
      _index--;
    });
  }

  void _goNext() {
    if (!_canGoNext) return;

    setState(() {
      _index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = _data.question;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        title: Text(
          'Question ${_data.questionNumber} of ${_items.length}',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Previous question',
            onPressed: _canGoPrevious ? _goPrevious : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: ReviewStatusBadge(
                isCorrect: _data.isCorrect,
                isFlagged: _data.isFlagged,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth > 720
                ? 720.0
                : constraints.maxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.question,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      if (question.image != null) ...[
                        const SizedBox(height: 18),
                        Center(
                          child: Image.asset(
                            question.image!,
                            height: 118,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      ...question.options.entries.map(
                        (entry) => ReviewOptionTile(
                          optionKey: entry.key,
                          optionText: entry.value,
                          selectedAnswer: _data.selectedAnswer,
                          correctAnswer: question.correctAnswer,
                          isFlagged: _data.isFlagged,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ReviewExplanationCard(
                        explanation: question.explanation,
                        imagePath: question.image,
                        isCorrect: _data.isCorrect,
                        isFlagged: _data.isFlagged,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _canGoPrevious ? _goPrevious : null,
                              icon: const Icon(Icons.chevron_left),
                              label: const Text('Previous'),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: _canGoNext ? _goNext : null,
                              icon: const Icon(Icons.chevron_right),
                              label: const Text('Next'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
