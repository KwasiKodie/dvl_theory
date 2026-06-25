import 'package:flutter/material.dart';

import '../../domain/services/notification_preferences_controller.dart';
import 'notification_setting_tile.dart';

class NotificationSettingsCard extends StatelessWidget {
  const NotificationSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NotificationPreferencesController.instance;
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final prefs = controller.preferences;

        return Card(
          elevation: 0,
          color: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                NotificationSettingTile(
                  title: 'Study Reminders',
                  subtitle: 'Get reminded to study daily',
                  value: prefs.studyReminders,
                  onChanged: controller.setStudyReminders,
                ),
                const _NotificationDivider(),

                NotificationSettingTile(
                  title: 'Test Reminders',
                  subtitle: 'Get reminded about mock tests',
                  value: prefs.testReminders,
                  onChanged: controller.setTestReminders,
                ),
                const _NotificationDivider(),

                NotificationSettingTile(
                  title: 'New Features',
                  subtitle: 'Updates about new features',
                  value: prefs.newFeatures,
                  onChanged: controller.setNewFeatures,
                ),
                const _NotificationDivider(),

                NotificationSettingTile(
                  title: 'Tip & Advice',
                  subtitle: 'Helpful driving tips and advice',
                  value: prefs.tipsAndAdvice,
                  onChanged: controller.setTipsAndAdvice,
                ),
                const _NotificationDivider(),

                NotificationSettingTile(
                  title: 'Promotions',
                  subtitle: 'Offers and promotions',
                  value: prefs.promotions,
                  onChanged: controller.setPromotions,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NotificationDivider extends StatelessWidget {
  const _NotificationDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
