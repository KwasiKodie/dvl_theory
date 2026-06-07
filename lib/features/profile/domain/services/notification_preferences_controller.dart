import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../../core/storage/hive_boxes.dart';
import '../../data/models/notification_preferences.dart';

class NotificationPreferencesController extends ChangeNotifier {
  NotificationPreferencesController._();

  static final NotificationPreferencesController instance =
      NotificationPreferencesController._();

  static const _key = 'notificationPreferences';

  NotificationPreferences preferences = NotificationPreferences.defaults();

  bool get canShowStudyReminders => preferences.studyReminders;

  bool get canShowTestReminders => preferences.testReminders;

  bool get canShowFeatureUpdates => preferences.newFeatures;

  bool get canShowTipsAndAdvice => preferences.tipsAndAdvice;

  bool get canShowPromotions => preferences.promotions;

  Future<void> load() async {
    final box = Hive.box(HiveBoxes.notificationPreferences);
    final raw = box.get(_key);

    if (raw == null) {
      preferences = NotificationPreferences.defaults();
      await box.put(_key, preferences.toMap());
    } else {
      preferences = NotificationPreferences.fromMap(
        Map<dynamic, dynamic>.from(raw),
      );
    }

    notifyListeners();
  }

  Future<void> update(NotificationPreferences value) async {
    preferences = value;

    final box = Hive.box(HiveBoxes.notificationPreferences);
    await box.put(_key, value.toMap());

    notifyListeners();
  }

  Future<void> setStudyReminders(bool value) {
    return update(preferences.copyWith(studyReminders: value));
  }

  Future<void> setTestReminders(bool value) {
    return update(preferences.copyWith(testReminders: value));
  }

  Future<void> setNewFeatures(bool value) {
    return update(preferences.copyWith(newFeatures: value));
  }

  Future<void> setTipsAndAdvice(bool value) {
    return update(preferences.copyWith(tipsAndAdvice: value));
  }

  Future<void> setPromotions(bool value) {
    return update(preferences.copyWith(promotions: value));
  }

  Future<void> resetToDefaults() {
    return update(NotificationPreferences.defaults());
  }
}
