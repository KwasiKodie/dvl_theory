import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../../domain/services/notification_center_service.dart';
import '../widgets/notification_tile.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  final _service = NotificationCenterService.instance;

  @override
  void initState() {
    super.initState();
    _service.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              _service.markAllRead();
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 720 : width),
            child: AnimatedBuilder(
              animation: _service,
              builder: (context, _) {
                final notifications = _service.notifications;

                if (notifications.isEmpty) {
                  return Center(
                    child: Text(
                      'No notifications available.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                  itemCount: notifications.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return NotificationTile(
                      notification: notifications[index],
                      onTap: () {
                        _service.markAsRead(notifications[index].id);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
