import '../../domain/services/practice_session_controller.dart';

class ReviewQuestionArguments {
  final List<ReviewQuestionData> questions;
  final int initialIndex;

  const ReviewQuestionArguments({
    required this.questions,
    required this.initialIndex,
  });
}
