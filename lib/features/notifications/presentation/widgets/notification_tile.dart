import 'package:flutter/material.dart';

import '../../data/models/app_notification.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback? onTap;

  const NotificationTile({super.key, required this.notification, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _colorFor(notification.type);

    return Card(
      elevation: 0,
      color: notification.isRead
          ? theme.colorScheme.surfaceContainerHighest.withOpacity(.20)
          : color.withOpacity(.15),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.14),
          child: Icon(_iconFor(notification.type), color: color),
        ),
        title: Text(
          notification.title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.w800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(notification.message),
        ),
      ),
    );
  }

  IconData _iconFor(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.studyReminder:
        return Icons.menu_book_rounded;
      case AppNotificationType.mockReminder:
        return Icons.assignment_turned_in;
      case AppNotificationType.drivingTip:
        return Icons.lightbulb_outline;
      case AppNotificationType.featureUpdate:
        return Icons.new_releases_rounded;
      case AppNotificationType.promotion:
        return Icons.local_offer;
    }
  }

  Color _colorFor(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.studyReminder:
        return Colors.blue;
      case AppNotificationType.mockReminder:
        return Colors.green;
      case AppNotificationType.drivingTip:
        return Colors.orange;
      case AppNotificationType.featureUpdate:
        return Colors.purple;
      case AppNotificationType.promotion:
        return Colors.pink;
    }
  }
}
