import 'notification_preferences_controller.dart';

class NotificationIntentService {
  NotificationIntentService._();

  static final NotificationIntentService instance =
      NotificationIntentService._();

  final _preferences = NotificationPreferencesController.instance;

  bool shouldShowStudyReminder() {
    return _preferences.canShowStudyReminders;
  }

  bool shouldShowMockReminder() {
    return _preferences.canShowTestReminders;
  }

  bool shouldShowFeatureUpdate() {
    return _preferences.canShowFeatureUpdates;
  }

  bool shouldShowTipOrAdvice() {
    return _preferences.canShowTipsAndAdvice;
  }

  bool shouldShowPromotion() {
    return _preferences.canShowPromotions;
  }
}
