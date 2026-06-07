import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../../core/storage/hive_boxes.dart';
import '../../data/models/study_preferences.dart';
import '../../../practice/domain/services/practice_session_controller.dart';
import '../../../mock/domain/services/mock_session_controller.dart';

class StudyPreferencesController extends ChangeNotifier {
  StudyPreferencesController._();

  static final StudyPreferencesController instance =
      StudyPreferencesController._();

  static const _key = 'studyPreferences';

  StudyPreferences preferences = StudyPreferences.defaults();

  Future<void> load() async {
    final box = Hive.box(HiveBoxes.studyPreferences);

    final raw = box.get(_key);

    if (raw == null) {
      preferences = StudyPreferences.defaults();

      await box.put(_key, preferences.toMap());
    } else {
      preferences = StudyPreferences.fromMap(Map<dynamic, dynamic>.from(raw));
    }

    notifyListeners();
  }

  Future<void> update(StudyPreferences value) async {
    preferences = value;

    final box = Hive.box(HiveBoxes.studyPreferences);
    await box.put(_key, value.toMap());

    if (!PracticeSessionController.instance.inProgress) {
      PracticeSessionController.instance.reset();
    }

    if (!MockSessionController.instance.inProgress) {
      MockSessionController.instance.reset();
    }

    notifyListeners();
  }

  Future<void> setPracticeTimerEnabled(bool value) {
    return update(preferences.copyWith(practiceTimerEnabled: value));
  }

  Future<void> setSaveWrongAnswers(bool value) {
    return update(preferences.copyWith(saveWrongAnswers: value));
  }

  Future<void> setAutoAdvance(bool value) {
    return update(preferences.copyWith(autoAdvance: value));
  }

  Future<void> setPracticeQuestionCount(int value) {
    return update(preferences.copyWith(practiceQuestionCount: value));
  }

  Future<void> setMockDurationMinutes(int value) {
    return update(preferences.copyWith(mockDurationMinutes: value));
  }

  Future<void> setExplanationMode(ExplanationMode value) {
    return update(preferences.copyWith(explanationMode: value));
  }

  Future<void> setQuestionMode(QuestionMode value) {
    return update(preferences.copyWith(questionMode: value));
  }

  Future<void> setRandomizeQuestions(bool value) {
    return update(preferences.copyWith(randomizeQuestions: value));
  }

  Future<void> setRandomizeAnswers(bool value) {
    return update(preferences.copyWith(randomizeAnswers: value));
  }
}
