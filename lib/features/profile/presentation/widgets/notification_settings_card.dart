import 'package:flutter/material.dart';

import 'notification_setting_tile.dart';

class NotificationSettingsCard extends StatefulWidget {
  const NotificationSettingsCard({super.key});

  @override
  State<NotificationSettingsCard> createState() =>
      _NotificationSettingsCardState();
}

class _NotificationSettingsCardState extends State<NotificationSettingsCard> {
  bool studyReminders = true;
  bool testReminders = true;
  bool newFeatures = true;
  bool tipsAdvice = true;
  bool promotions = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,

      color: theme.colorScheme.surface,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),

        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),

        child: Column(
          children: [
            NotificationSettingTile(
              title: 'Study Reminders',
              subtitle: 'Get reminded to study daily',
              value: studyReminders,
              onChanged: (value) {
                setState(() {
                  studyReminders = value;
                });
              },
            ),

            const _NotificationDivider(),

            NotificationSettingTile(
              title: 'Test Reminders',
              subtitle: 'Get reminded about mock tests',
              value: testReminders,
              onChanged: (value) {
                setState(() {
                  testReminders = value;
                });
              },
            ),

            const _NotificationDivider(),

            NotificationSettingTile(
              title: 'New Features',
              subtitle: 'Updates about new features',
              value: newFeatures,
              onChanged: (value) {
                setState(() {
                  newFeatures = value;
                });
              },
            ),

            const _NotificationDivider(),

            NotificationSettingTile(
              title: 'Tip & Advice',
              subtitle: 'Helpful driving tips and advice',
              value: tipsAdvice,
              onChanged: (value) {
                setState(() {
                  tipsAdvice = value;
                });
              },
            ),

            const _NotificationDivider(),

            NotificationSettingTile(
              title: 'Promotions',
              subtitle: 'Offers and promotions',
              value: promotions,
              onChanged: (value) {
                setState(() {
                  promotions = value;
                });
              },
            ),
          ],
        ),
      ),
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
