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

  void reset() {
    questions = [];
    currentIndex = 0;
    selectedAnswers.clear();
    answeredQuestions.clear();
    initialized = false;
  }
}
