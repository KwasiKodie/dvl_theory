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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionId': questionId,
      'category': category,
      'selectedAnswer': selectedAnswer,
      'correctAnswer': correctAnswer,
      'isCorrect': isCorrect,
      'timeTaken': timeTaken,
      'date': date.toIso8601String(),
      'testType': testType,
    };
  }

  factory QuestionAttemptModel.fromMap(Map<dynamic, dynamic> map) {
    return QuestionAttemptModel(
      id: map['id']?.toString() ?? '',
      questionId: (map['questionId'] ?? 0) as int,
      category: map['category']?.toString() ?? '',
      selectedAnswer: map['selectedAnswer']?.toString() ?? '',
      correctAnswer: map['correctAnswer']?.toString() ?? '',
      isCorrect: map['isCorrect'] == true,
      timeTaken: (map['timeTaken'] ?? 0) as int,
      date: DateTime.parse(map['date'].toString()),
      testType: map['testType']?.toString() ?? '',
    );
  }

  QuestionAttemptModel copyWith({
    String? id,
    int? questionId,
    String? category,
    String? selectedAnswer,
    String? correctAnswer,
    bool? isCorrect,
    int? timeTaken,
    DateTime? date,
    String? testType,
  }) {
    return QuestionAttemptModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      category: category ?? this.category,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      isCorrect: isCorrect ?? this.isCorrect,
      timeTaken: timeTaken ?? this.timeTaken,
      date: date ?? this.date,
      testType: testType ?? this.testType,
    );
  }
}
