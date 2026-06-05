import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import '../../data/models/review_question_arguments.dart';
import '../../domain/services/practice_session_controller.dart';
import 'review_question_tile.dart';

class ReviewQuestionList extends StatelessWidget {
  final List<ReviewQuestionData> questions;

  const ReviewQuestionList({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: questions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (_, index) {
        final item = questions[index];

        return ReviewQuestionTile(
          questionNumber: item.questionNumber,
          isCorrect: item.isCorrect,
          isFlagged: item.isFlagged,
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.reviewQuestion,
              arguments: ReviewQuestionArguments(
                questions: questions,
                initialIndex: index,
              ),
            );
          },
        );
      },
    );
  }
}
