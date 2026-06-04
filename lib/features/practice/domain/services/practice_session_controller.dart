import '../../data/models/question_model.dart';

class PracticeSessionController {
  PracticeSessionController._();

  static final PracticeSessionController instance =
      PracticeSessionController._();

  List<QuestionModel> questions = [];
  int currentIndex = 0;
  bool initialized = false;

  final Map<int, String> selectedAnswers = {};
  final Map<int, bool> answeredQuestions = {};
  final Map<int, bool> questionResults = {};
  final Set<int> flaggedQuestions = {};

  void toggleFlag(int questionId) {
    if (flaggedQuestions.contains(questionId)) {
      flaggedQuestions.remove(questionId);
    } else {
      flaggedQuestions.add(questionId);
    }
  }

  List<ReviewQuestionData> buildReviewData() {
    return questions.asMap().entries.map((entry) {
      final index = entry.key;
      final question = entry.value;
      final selectedAnswer = selectedAnswers[question.id];

      final isAnswered = answeredQuestions[question.id] ?? false;
      final isCorrect = isAnswered && selectedAnswer == question.correctAnswer;

      return ReviewQuestionData(
        question: question,
        questionNumber: index + 1,
        selectedAnswer: selectedAnswer,
        isCorrect: isCorrect,
        isAnswered: isAnswered,
        isFlagged: flaggedQuestions.contains(question.id),
      );
    }).toList();
  }

  void reset() {
    questions = [];
    currentIndex = 0;
    initialized = false;
    selectedAnswers.clear();
    answeredQuestions.clear();
    questionResults.clear();
    flaggedQuestions.clear();
  }
}

class ReviewQuestionData {
  final QuestionModel question;
  final int questionNumber;
  final String? selectedAnswer;
  final bool isCorrect;
  final bool isAnswered;
  final bool isFlagged;

  const ReviewQuestionData({
    required this.question,
    required this.questionNumber,
    required this.selectedAnswer,
    required this.isCorrect,
    required this.isAnswered,
    required this.isFlagged,
  });

  bool get isWrong => isAnswered && !isCorrect;
}
