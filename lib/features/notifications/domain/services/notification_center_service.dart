import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../../core/storage/hive_boxes.dart';
import '../../../analytics/domain/services/readiness_service.dart';
import '../../../home/domain/services/driving_tip_service.dart';
import '../../../profile/domain/services/notification_preferences_controller.dart';
import '../../data/models/app_notification.dart';

class NotificationCenterService extends ChangeNotifier {
  NotificationCenterService._();

  static final NotificationCenterService instance =
      NotificationCenterService._();

  static const _readIdsKey = 'read_notification_ids';

  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((item) => !item.isRead).length;

  Set<String> _readIds() {
    final box = Hive.box(HiveBoxes.notifications);

    final raw = box.get(_readIdsKey, defaultValue: <String>[]);

    return List<String>.from(raw).toSet();
  }

  Future<void> _saveReadIds(Set<String> ids) async {
    final box = Hive.box(HiveBoxes.notifications);
    await box.put(_readIdsKey, ids.toList());
  }

  Future<void> refresh() async {
    final prefs = NotificationPreferencesController.instance;
    final readiness = ReadinessService().generateReport();
    final readIds = _readIds();

    final items = <AppNotification>[];
    final now = DateTime.now();

    if (prefs.canShowFeatureUpdates) {
      items.add(
        AppNotification(
          id: 'feature_mock_tests',
          title: 'New Feature',
          message: 'Mock Tests are now available.',
          type: AppNotificationType.featureUpdate,
          createdAt: now,
          isRead: readIds.contains('feature_mock_tests'),
        ),
      );
    }

    if (prefs.canShowStudyReminders) {
      items.add(
        AppNotification(
          id: 'study_reminder_today',
          title: 'Study Reminder',
          message:
              'Continue your practice today to improve your readiness score.',
          type: AppNotificationType.studyReminder,
          createdAt: now,
          isRead: readIds.contains('study_reminder_today'),
        ),
      );
    }

    if (prefs.canShowTestReminders && readiness.readinessScore >= 60) {
      final id = 'mock_reminder_${readiness.readinessScore.round()}';

      items.add(
        AppNotification(
          id: id,
          title: 'Mock Test Recommended',
          message:
              'Your readiness score is ${readiness.readinessScore.round()}%. Take a mock test.',
          type: AppNotificationType.mockReminder,
          createdAt: now,
          isRead: readIds.contains(id),
        ),
      );
    }

    if (prefs.canShowTipsAndAdvice) {
      final tip = await DrivingTipService.instance.getTipOfTheDay();
      final today = DateTime.now();
      final id = 'driving_tip_${today.year}_${today.month}_${today.day}';

      items.add(
        AppNotification(
          id: id,
          title: 'Driving Tip',
          message: tip,
          type: AppNotificationType.drivingTip,
          createdAt: now,
          isRead: readIds.contains(id),
        ),
      );
    }

    _notifications
      ..clear()
      ..addAll(items);

    notifyListeners();
  }

  Future<void> markAsRead(String id) async {
    final index = _notifications.indexWhere((item) => item.id == id);

    if (index == -1) return;

    _notifications[index] = _notifications[index].copyWith(isRead: true);

    final readIds = _readIds()..add(id);
    await _saveReadIds(readIds);

    notifyListeners();
  }

  Future<void> markAllRead() async {
    final readIds = _readIds();

    for (var i = 0; i < _notifications.length; i++) {
      readIds.add(_notifications[i].id);

      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }

    await _saveReadIds(readIds);

    notifyListeners();
  }
}
