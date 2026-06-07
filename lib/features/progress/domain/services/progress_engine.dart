// ===========================
// features/progress/domain/services/progress_engine.dart
// ===========================
import 'package:hive/hive.dart';

import '../../../../core/storage/hive_boxes.dart';
import '../../../profile/domain/services/study_preferences_controller.dart';

class ProgressEngine {
  final Box attemptsBox = Hive.box(HiveBoxes.attempts);
  final Box categoryBox = Hive.box(HiveBoxes.category);
  final Box statsBox = Hive.box(HiveBoxes.stats);
  final Box wrongBox = Hive.box(HiveBoxes.wrong);
  final Box masteryBox = Hive.box(HiveBoxes.mastery);
  final Box reviewBox = Hive.box(HiveBoxes.review);
  final Box streakBox = Hive.box(HiveBoxes.streak);

  void recordAttempt(Map<String, dynamic> attempt) {
    final preferences = StudyPreferencesController.instance.preferences;
    final enrichedAttempt = Map<String, dynamic>.from(attempt)
      ..['saveWrongAnswersEnabled'] = preferences.saveWrongAnswers
      ..['practiceQuestionCount'] = preferences.practiceQuestionCount
      ..['explanationMode'] = preferences.explanationMode.name
      ..['questionMode'] = preferences.questionMode.name;

    attemptsBox.add(enrichedAttempt);

    _updateStats(enrichedAttempt);
    _updateCategory(enrichedAttempt);

    if (preferences.saveWrongAnswers) {
      _updateWrongAnswers(enrichedAttempt);
    }

    _updateMastery(enrichedAttempt);
    _updateSpacedRepetition(enrichedAttempt);
    _updateStreak();
  }

  void _updateStats(Map<String, dynamic> attempt) {
    final stats = Map<String, dynamic>.from(
      statsBox.get('stats') ??
          <String, dynamic>{
            'totalQuestionsAnswered': 0,
            'totalCorrectAnswers': 0,
            'totalIncorrectAnswers': 0,
            'totalTime': 0,
            'accuracy': 0.0,
            'averageResponseTime': 0.0,
          },
    );

    stats['totalQuestionsAnswered'] =
        (stats['totalQuestionsAnswered'] as num).toInt() + 1;

    if (attempt['isCorrect'] == true) {
      stats['totalCorrectAnswers'] =
          (stats['totalCorrectAnswers'] as num).toInt() + 1;
    } else {
      stats['totalIncorrectAnswers'] =
          (stats['totalIncorrectAnswers'] as num).toInt() + 1;
    }

    stats['totalTime'] =
        (stats['totalTime'] as num).toInt() +
        ((attempt['timeTaken'] ?? 0) as num).toInt();

    final total = (stats['totalQuestionsAnswered'] as num).toInt();
    final correct = (stats['totalCorrectAnswers'] as num).toInt();
    final totalTime = (stats['totalTime'] as num).toInt();

    stats['accuracy'] = total > 0 ? (correct / total) * 100.0 : 0.0;
    stats['averageResponseTime'] = total > 0 ? totalTime / total : 0.0;

    statsBox.put('stats', stats);
  }

  void _updateCategory(Map<String, dynamic> attempt) {
    final category = attempt['category'].toString();
    final isCorrect = attempt['isCorrect'] == true;
    final timeTaken = ((attempt['timeTaken'] ?? 0) as num).toInt();

    final existing = Map<String, dynamic>.from(
      categoryBox.get(category) ??
          <String, dynamic>{
            'attempted': 0,
            'correct': 0,
            'incorrect': 0,
            'totalTime': 0,
            'accuracy': 0.0,
            'averageTime': 0.0,
            'status': 'Weak',
          },
    );

    existing['attempted'] = (existing['attempted'] as num).toInt() + 1;

    if (isCorrect) {
      existing['correct'] = (existing['correct'] as num).toInt() + 1;
    } else {
      existing['incorrect'] = (existing['incorrect'] as num).toInt() + 1;
    }

    existing['totalTime'] = (existing['totalTime'] as num).toInt() + timeTaken;

    final attempted = (existing['attempted'] as num).toInt();
    final correct = (existing['correct'] as num).toInt();
    final totalTime = (existing['totalTime'] as num).toInt();

    final accuracy = attempted > 0 ? (correct / attempted) * 100.0 : 0.0;

    existing['accuracy'] = accuracy;
    existing['averageTime'] = attempted > 0 ? totalTime / attempted : 0.0;
    existing['status'] = _getCategoryStatus(accuracy);

    categoryBox.put(category, existing);
  }

  void _updateWrongAnswers(Map<String, dynamic> attempt) {
    final questionId = ((attempt['questionId'] ?? 0) as num).toInt();
    final isCorrect = attempt['isCorrect'] == true;

    final existingRaw = wrongBox.get(questionId);
    final existing = existingRaw == null
        ? null
        : Map<String, dynamic>.from(existingRaw);

    if (!isCorrect) {
      if (existing == null) {
        wrongBox.put(questionId, {
          'questionId': questionId,
          'category': attempt['category'],
          'wrongCount': 1,
          'lastAttempt': DateTime.now(),
          'resolved': false,
        });
      } else {
        existing['wrongCount'] =
            ((existing['wrongCount'] ?? 0) as num).toInt() + 1;
        existing['lastAttempt'] = DateTime.now();
        existing['resolved'] = false;
        wrongBox.put(questionId, existing);
      }
    } else {
      if (existing != null) {
        existing['resolved'] = true;
        wrongBox.put(questionId, existing);
      }
    }
  }

  void _updateMastery(Map<String, dynamic> attempt) {
    final questionId = ((attempt['questionId'] ?? 0) as num).toInt();
    final isCorrect = attempt['isCorrect'] == true;

    final existing = Map<String, dynamic>.from(
      masteryBox.get(questionId) ??
          <String, dynamic>{
            'correct': 0,
            'incorrect': 0,
            'masteryScore': 0.0,
            'level': 'Beginner',
          },
    );

    if (isCorrect) {
      existing['correct'] = (existing['correct'] as num).toInt() + 1;
    } else {
      existing['incorrect'] = (existing['incorrect'] as num).toInt() + 1;
    }

    final correct = (existing['correct'] as num).toInt();
    final incorrect = (existing['incorrect'] as num).toInt();
    final total = correct + incorrect;

    final score = total > 0 ? correct / total : 0.0;

    existing['masteryScore'] = score;
    existing['level'] = _getMasteryLevel(score);

    masteryBox.put(questionId, existing);
  }

  void _updateSpacedRepetition(Map<String, dynamic> attempt) {
    final questionId = ((attempt['questionId'] ?? 0) as num).toInt();
    final isCorrect = attempt['isCorrect'] == true;
    final now = DateTime.now();

    final existing = Map<String, dynamic>.from(
      reviewBox.get(questionId) ??
          <String, dynamic>{
            'questionId': questionId,
            'level': 0,
            'nextReview': now,
            'lastReviewed': now,
          },
    );

    int level = ((existing['level'] ?? 0) as num).toInt();

    level = isCorrect ? level + 1 : 0;

    final nextReview = switch (level) {
      0 => now,
      1 => now.add(const Duration(days: 1)),
      2 => now.add(const Duration(days: 3)),
      3 => now.add(const Duration(days: 7)),
      _ => now.add(const Duration(days: 30)),
    };

    reviewBox.put(questionId, {
      'questionId': questionId,
      'level': level,
      'nextReview': nextReview,
      'lastReviewed': now,
    });
  }

  void _updateStreak() {
    final today = DateTime.now();

    final streak = Map<String, dynamic>.from(
      streakBox.get('streak') ??
          <String, dynamic>{'current': 0, 'longest': 0, 'lastDate': null},
    );

    DateTime? lastDate;

    final rawLastDate = streak['lastDate'];

    if (rawLastDate is DateTime) {
      lastDate = rawLastDate;
    } else if (rawLastDate is String) {
      lastDate = DateTime.tryParse(rawLastDate);
    }

    if (lastDate == null) {
      streak['current'] = 1;
    } else {
      final todayDate = DateTime(today.year, today.month, today.day);
      final lastOnlyDate = DateTime(
        lastDate.year,
        lastDate.month,
        lastDate.day,
      );

      final difference = todayDate.difference(lastOnlyDate).inDays;

      if (difference == 1) {
        streak['current'] = ((streak['current'] ?? 0) as num).toInt() + 1;
      } else if (difference > 1) {
        streak['current'] = 1;
      }
    }

    final current = ((streak['current'] ?? 0) as num).toInt();
    final longest = ((streak['longest'] ?? 0) as num).toInt();

    if (current > longest) {
      streak['longest'] = current;
    }

    streak['lastDate'] = today.toIso8601String();

    streakBox.put('streak', streak);
  }

  // ===========================
  // Public Statistics API
  // ===========================

  Map<String, dynamic> getStats() {
    return Map<String, dynamic>.from(
      statsBox.get('stats') ??
          <String, dynamic>{
            'totalQuestionsAnswered': 0,
            'totalCorrectAnswers': 0,
            'totalIncorrectAnswers': 0,
            'totalTime': 0,
            'accuracy': 0.0,
            'averageResponseTime': 0.0,
          },
    );
  }

  int totalAnswered() {
    return (getStats()['totalQuestionsAnswered'] as num).toInt();
  }

  int totalCorrect() {
    return (getStats()['totalCorrectAnswers'] as num).toInt();
  }

  int totalIncorrect() {
    return (getStats()['totalIncorrectAnswers'] as num).toInt();
  }

  int totalTimeSpent() {
    return (getStats()['totalTime'] as num).toInt();
  }

  double overallAccuracy() {
    return (getStats()['accuracy'] as num).toDouble();
  }

  double averageResponseTime() {
    return (getStats()['averageResponseTime'] as num).toDouble();
  }

  int totalQuestions() {
    final stats = getStats();

    return (stats['totalCorrectAnswers'] as num).toInt() +
        (stats['totalIncorrectAnswers'] as num).toInt();
  }

  String _getCategoryStatus(double accuracy) {
    if (accuracy <= 50) return 'Weak';
    if (accuracy <= 75) return 'Improving';
    if (accuracy <= 90) return 'Good';
    return 'Mastered';
  }

  String _getMasteryLevel(double score) {
    if (score < 0.3) return 'Beginner';
    if (score < 0.5) return 'Learning';
    if (score < 0.7) return 'Improving';
    if (score < 0.9) return 'Proficient';
    return 'Mastered';
  }
}
