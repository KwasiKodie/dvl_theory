// ===========================
// home_bottom_navigation.dart
// ===========================
import 'package:flutter/material.dart';

import '../../../core/navigation/navigation_items.dart';
import '../../../core/utils/responsive.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final isSmallPhone = Responsive.isSmallPhone(context);
    final isTablet = Responsive.isTablet(context);

    final items = NavigationItems.items;

    return NavigationBar(
      selectedIndex: currentIndex,
      height: isTablet ? 82 : 72,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.14),
      labelBehavior: isSmallPhone
          ? NavigationDestinationLabelBehavior.onlyShowSelected
          : NavigationDestinationLabelBehavior.alwaysShow,
      onDestinationSelected: (index) {
        final selectedRoute = items[index].route;
        final currentRoute = ModalRoute.of(context)?.settings.name;

        if (currentRoute == selectedRoute) return;

        Navigator.pushReplacementNamed(context, selectedRoute);
      },
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Tooltip(message: item.label, child: Icon(item.icon)),
          selectedIcon: Tooltip(
            message: item.label,
            child: Icon(item.selectedIcon),
          ),
          label: item.label,
        );
      }).toList(),
    );
  }
}
