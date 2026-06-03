import 'dart:math';

import 'package:hive/hive.dart';

import '../../../../core/storage/hive_boxes.dart';
import '../../data/models/question_model.dart';

class AdaptivePracticeService {
  final Box categoryBox = Hive.box(HiveBoxes.category);
  final Box masteryBox = Hive.box(HiveBoxes.mastery);

  List<QuestionModel> generateSession(
    List<QuestionModel> allQuestions, {
    int sessionSize = 20,
  }) {
    if (allQuestions.isEmpty) return [];

    final random = Random();

    final weak = <QuestionModel>[];
    final medium = <QuestionModel>[];
    final mastered = <QuestionModel>[];

    for (final question in allQuestions) {
      final categoryData = categoryBox.get(question.category);
      final masteryData = masteryBox.get(question.id);

      final categoryAccuracy = categoryData == null
          ? 0.0
          : ((categoryData['accuracy'] ?? 0) as num).toDouble();

      final masteryScore = masteryData == null
          ? 0.0
          : ((masteryData['masteryScore'] ?? 0) as num).toDouble();

      if (categoryAccuracy < 50 || masteryScore < 0.5) {
        weak.add(question);
      } else if (categoryAccuracy < 80 || masteryScore < 0.85) {
        medium.add(question);
      } else {
        mastered.add(question);
      }
    }

    weak.shuffle(random);
    medium.shuffle(random);
    mastered.shuffle(random);

    final weakCount = (sessionSize * 0.7).round();
    final mediumCount = (sessionSize * 0.2).round();
    final masteredCount = sessionSize - weakCount - mediumCount;

    final selected = <QuestionModel>[
      ...weak.take(weakCount),
      ...medium.take(mediumCount),
      ...mastered.take(masteredCount),
    ];

    if (selected.length < sessionSize) {
      final selectedIds = selected.map((q) => q.id).toSet();

      final fallback =
          allQuestions.where((q) => !selectedIds.contains(q.id)).toList()
            ..shuffle(random);

      selected.addAll(fallback.take(sessionSize - selected.length));
    }

    selected.shuffle(random);

    return selected.take(sessionSize).toList();
  }
}
