import '../../../profile/domain/services/notification_preferences_controller.dart';
import 'local_notification_service.dart';

class NotificationScheduler {
  NotificationScheduler._();

  static final NotificationScheduler instance = NotificationScheduler._();

  static const int studyReminderId = 1001;
  static const int mockReminderId = 1002;
  static const int drivingTipId = 1003;

  Future<void> rescheduleAll() async {
    final prefs = NotificationPreferencesController.instance.preferences;

    await LocalNotificationService.instance.cancelAll();

    if (prefs.studyReminders) {
      await LocalNotificationService.instance.scheduleDailyNotification(
        id: studyReminderId,
        title: 'Study Reminder',
        body: 'Continue your practice today to improve your readiness.',
        hour: 19,
        minute: 0,
      );
    }

    if (prefs.testReminders) {
      await LocalNotificationService.instance.scheduleDailyNotification(
        id: mockReminderId,
        title: 'Mock Test Reminder',
        body: 'Take a mock test today and track your progress.',
        hour: 20,
        minute: 0,
      );
    }

    if (prefs.tipsAndAdvice) {
      await LocalNotificationService.instance.scheduleDailyNotification(
        id: drivingTipId,
        title: 'Driving Tip',
        body: 'Open DVL Theory for today’s driving tip.',
        hour: 9,
        minute: 0,
      );
    }
  }
}
