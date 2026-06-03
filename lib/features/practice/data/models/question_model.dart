class QuestionModel {
  final int id;
  final String category;
  final String question;
  final String? image;
  final String explanation;
  final String? source;

  final Map<String, String> options;
  final String correctAnswer;

  const QuestionModel({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.source,
    this.image,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["question_number"] ?? 0,
      question: json["question"] ?? "",
      options: Map<String, String>.from(
        (json["options"] as Map).map(
          (k, v) => MapEntry(k.toString().toUpperCase(), v.toString()),
        ),
      ),
      correctAnswer: (json["correct_answer"] ?? "").toString().toUpperCase(),
      category: json["category"] ?? "General",
      image: json["image"],

      explanation: json["explanation"] ?? "Explanation unavailable.",

      source: json["source"] ?? "Official DVL Theory Material",
    );
  }
}
