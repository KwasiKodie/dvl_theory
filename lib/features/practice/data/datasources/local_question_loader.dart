import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question_model.dart';

class LocalQuestionLoader {
  Future<List<QuestionModel>> loadQuestions() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/questions.json',
    );

    final List<dynamic> data = json.decode(jsonString);

    return data.map((q) => QuestionModel.fromJson(q)).toList();
  }
}
