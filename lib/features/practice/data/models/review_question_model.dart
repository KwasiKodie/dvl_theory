class ReviewQuestionModel {
  final int questionId;
  final int questionNumber;

  final bool isCorrect;
  final bool isFlagged;

  const ReviewQuestionModel({
    required this.questionId,
    required this.questionNumber,
    required this.isCorrect,
    required this.isFlagged,
  });
}
