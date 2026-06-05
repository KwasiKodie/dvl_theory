import '../../../practice/data/models/question_model.dart';
import '../../../practice/domain/services/practice_session_controller.dart';

class MockSessionController {
  MockSessionController._();

  static final MockSessionController instance = MockSessionController._();

  List<QuestionModel> questions = [];
  int currentIndex = 0;
  bool initialized = false;
  bool submitted = false;

  Duration totalTime = const Duration(minutes: 30);
  Duration remainingTime = const Duration(minutes: 30);

  final Map<int, String> selectedAnswers = {};
  final Set<int> flaggedQuestions = {};

  int get totalQuestions => questions.length;

  QuestionModel get currentQuestion => questions[currentIndex];

  String? selectedAnswerFor(int questionId) => selectedAnswers[questionId];

  bool isFlagged(int questionId) => flaggedQuestions.contains(questionId);

  int get answeredCount => selectedAnswers.length;

  int get flaggedCount => flaggedQuestions.length;

  int get unansweredCount => totalQuestions - answeredCount;

  int get correctCount {
    return questions.where((question) {
      return selectedAnswers[question.id] == question.correctAnswer;
    }).length;
  }

  int get wrongCount => answeredCount - correctCount;

  double get scorePercent {
    if (totalQuestions == 0) return 0;
    return (correctCount / totalQuestions) * 100;
  }

  bool get passed => correctCount >= passingScore;

  int get passingScore => (totalQuestions * 0.70).ceil();

  void selectAnswer(String answer) {
    selectedAnswers[currentQuestion.id] = answer;
  }

  void toggleFlag() {
    final id = currentQuestion.id;

    if (flaggedQuestions.contains(id)) {
      flaggedQuestions.remove(id);
    } else {
      flaggedQuestions.add(id);
    }
  }

  void moveNext() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
    }
  }

  void movePrevious() {
    if (currentIndex > 0) {
      currentIndex--;
    }
  }

  List<ReviewQuestionData> buildReviewData() {
    return questions.asMap().entries.map((entry) {
      final index = entry.key;
      final question = entry.value;
      final selectedAnswer = selectedAnswers[question.id];
      final isAnswered = selectedAnswer != null;
      final isCorrect = selectedAnswer == question.correctAnswer;

      return ReviewQuestionData(
        question: question,
        questionNumber: index + 1,
        selectedAnswer: selectedAnswer,
        isCorrect: isAnswered && isCorrect,
        isAnswered: isAnswered,
        isFlagged: flaggedQuestions.contains(question.id),
      );
    }).toList();
  }

  void reset() {
    questions = [];
    currentIndex = 0;
    initialized = false;
    submitted = false;
    remainingTime = totalTime;
    selectedAnswers.clear();
    flaggedQuestions.clear();
  }
}
