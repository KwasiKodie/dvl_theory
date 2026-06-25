// ===========================
// home_bottom_navigation.dart
// ===========================
import 'package:flutter/material.dart';

import '../../../core/navigation/navigation_items.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/navigation/route_names.dart';
import '../../../features/mock/domain/services/mock_session_controller.dart';
import '../../../features/notifications/domain/services/notification_center_service.dart';
import '../../../features/notifications/presentation/widgets/notification_badge.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final isSmallPhone = Responsive.isSmallPhone(context);
    final isTablet = Responsive.isTablet(context);

    final items = NavigationItems.items;

    NotificationCenterService.instance.refresh();

    return NavigationBar(
      selectedIndex: currentIndex,
      height: isTablet ? 82 : 72,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.14),
      labelBehavior: isSmallPhone
          ? NavigationDestinationLabelBehavior.onlyShowSelected
          : NavigationDestinationLabelBehavior.alwaysShow,
      onDestinationSelected: (index) {
        String selectedRoute = items[index].route;

        if (selectedRoute == RouteNames.mockIntro) {
          final mockSession = MockSessionController.instance;

          if (mockSession.inProgress &&
              mockSession.initialized &&
              mockSession.questions.isNotEmpty) {
            selectedRoute = RouteNames.mockExam;
          }
        }

        final currentRoute = ModalRoute.of(context)?.settings.name;

        if (currentRoute == selectedRoute) return;

        Navigator.pushNamedAndRemoveUntil(
          context,
          selectedRoute,
          (route) => false,
        );
      },
      destinations: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return NavigationDestination(
          icon: Tooltip(
            message: item.label,
            child: index == 4
                ? AnimatedBuilder(
                    animation: NotificationCenterService.instance,
                    builder: (context, child) {
                      return NotificationBadge(
                        count: NotificationCenterService.instance.unreadCount,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(item.icon),
                        ),
                      );
                    },
                  )
                : Icon(item.icon),
          ),
          selectedIcon: Tooltip(
            message: item.label,
            child: index == 4
                ? AnimatedBuilder(
                    animation: NotificationCenterService.instance,
                    builder: (context, child) {
                      return NotificationBadge(
                        count: NotificationCenterService.instance.unreadCount,
                        child: Icon(item.selectedIcon),
                      );
                    },
                  )
                : Icon(item.selectedIcon),
          ),
          label: item.label,
        );
      }).toList(),
    );
  }
}
