import '../../../practice/data/models/question_model.dart';
import '../../../practice/domain/services/practice_session_controller.dart';
import '../../../profile/domain/services/study_preferences_controller.dart';
import '../../data/models/mock_configuration.dart';

class MockSessionController {
  MockSessionController._();

  static final MockSessionController instance = MockSessionController._();

  List<QuestionModel> questions = [];
  int currentIndex = 0;
  bool initialized = false;
  bool submitted = false;
  bool inProgress = false;

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

  void applyPreferences() {
    final prefs = StudyPreferencesController.instance.preferences;

    totalTime = Duration(minutes: prefs.mockDurationMinutes);

    remainingTime = totalTime;
  }

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

  void startSession() {
    inProgress = true;
  }

  void finishSession() {
    inProgress = false;
    reset();
  }

  void moveNext() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
    }
  }

  void reset() {
    questions.clear();
    selectedAnswers.clear();
    flaggedQuestions.clear();

    currentIndex = 0;
    remainingTime = totalTime;

    inProgress = false;
    initialized = false;
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

  MockConfiguration buildConfiguration() {
    final prefs = StudyPreferencesController.instance.preferences;

    return MockConfiguration(
      questionCount: prefs.practiceQuestionCount,
      timed: true,
      randomQuestions: prefs.randomizeQuestions,
      passingScore: (prefs.practiceQuestionCount * 0.70).ceil(),
    );
  }
}
