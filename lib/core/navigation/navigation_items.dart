// ===========================
// navigation_items.dart
// ===========================
import 'package:flutter/material.dart';

import 'route_names.dart';
import 'navigation_item.dart';

class NavigationItems {
  static const items = [
    NavigationItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      route: RouteNames.home,
    ),
    NavigationItem(
      label: 'Practice',
      icon: Icons.book_outlined,
      selectedIcon: Icons.book,
      route: RouteNames.practice,
    ),
    NavigationItem(
      label: 'Mock',
      icon: Icons.school_outlined,
      selectedIcon: Icons.school,
      route: RouteNames.mockExam,
    ),
    NavigationItem(
      label: 'Progress',
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart,
      route: RouteNames.progress,
    ),
    NavigationItem(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      route: RouteNames.profile,
    ),
  ];
}
