import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class QuestionAttemptModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  int questionId;
  @HiveField(2)
  String category;
  @HiveField(3)
  String selectedAnswer;
  @HiveField(4)
  String correctAnswer;
  @HiveField(5)
  bool isCorrect;
  @HiveField(6)
  int timeTaken;
  @HiveField(7)
  DateTime date;
  @HiveField(8)
  String testType;

  QuestionAttemptModel({
    required this.id,
    required this.questionId,
    required this.category,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.timeTaken,
    required this.date,
    required this.testType,
  });
}
