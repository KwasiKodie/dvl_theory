import 'package:flutter/material.dart';

import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../../domain/services/practice_session_controller.dart';
import '../widgets/review_filter_chip.dart';
import '../widgets/review_question_list.dart';

enum ReviewFilter { all, correct, wrong, flagged }

class ReviewScreen extends StatefulWidget {
  final List<ReviewQuestionData> reviewData;

  const ReviewScreen({super.key, required this.reviewData});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  ReviewFilter _filter = ReviewFilter.all;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final reviewData = widget.reviewData;

    final filtered = _filteredQuestions(reviewData);

    final total = reviewData.length;

    final correct = reviewData.where((e) => e.isCorrect).length;

    final wrong = reviewData.where((e) => e.isWrong).length;

    final flagged = reviewData.where((e) => e.isFlagged).length;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.background,
        title: const Text('Review Answers'),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ReviewFilterChip(
                    label: 'ALL ($total)',
                    selected: _filter == ReviewFilter.all,
                    color: Colors.blue,
                    onTap: () {
                      setState(() {
                        _filter = ReviewFilter.all;
                      });
                    },
                  ),

                  ReviewFilterChip(
                    label: 'Correct ($correct)',
                    selected: _filter == ReviewFilter.correct,
                    color: Colors.green,
                    onTap: () {
                      setState(() {
                        _filter = ReviewFilter.correct;
                      });
                    },
                  ),

                  ReviewFilterChip(
                    label: 'Wrong ($wrong)',
                    selected: _filter == ReviewFilter.wrong,
                    color: Colors.red,
                    onTap: () {
                      setState(() {
                        _filter = ReviewFilter.wrong;
                      });
                    },
                  ),

                  ReviewFilterChip(
                    label: 'Flagged ($flagged)',
                    selected: _filter == ReviewFilter.flagged,
                    color: Colors.orange,
                    onTap: () {
                      setState(() {
                        _filter = ReviewFilter.flagged;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Expanded(child: ReviewQuestionList(questions: filtered)),
            ],
          ),
        ),
      ),
    );
  }

  List<ReviewQuestionData> _filteredQuestions(List<ReviewQuestionData> items) {
    switch (_filter) {
      case ReviewFilter.correct:
        return items.where((e) => e.isCorrect).toList();

      case ReviewFilter.wrong:
        return items.where((e) => e.isWrong).toList();

      case ReviewFilter.flagged:
        return items.where((e) => e.isFlagged).toList();

      case ReviewFilter.all:
        return items;
    }
  }
}
