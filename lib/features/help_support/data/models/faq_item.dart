class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});

  factory FaqItem.fromMap(Map<String, dynamic> map) {
    return FaqItem(
      question: map['question']?.toString() ?? '',
      answer: map['answer']?.toString() ?? '',
    );
  }
}
