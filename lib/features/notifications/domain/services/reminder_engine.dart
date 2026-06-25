import 'notification_center_service.dart';
import 'notification_scheduler.dart';

class ReminderEngine {
  ReminderEngine._();

  static final ReminderEngine instance = ReminderEngine._();

  Future<void> initialize() async {
    await NotificationCenterService.instance.refresh();
    await NotificationScheduler.instance.rescheduleAll();
  }

  Future<void> refresh() async {
    await NotificationCenterService.instance.refresh();
    await NotificationScheduler.instance.rescheduleAll();
  }
}
