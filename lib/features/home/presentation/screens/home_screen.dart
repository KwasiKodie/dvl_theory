import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../../../progress/domain/services/category_service.dart';
import '../widgets/home_category_mapper.dart';
import '../widgets/home_category_tile.dart';
import '../widgets/home_logo_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> _defaultCategories = [
    'Road signs',
    'Road markings',
    'Traffic rules',
    'Speed limits',
    'Hazard awareness',
    'Safe driving',
    'Vehicle handling',
    'Motorway rules',
    'Pedestrian crossings',
    'Emergency procedures',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);
    final width = MediaQuery.of(context).size.width;

    final categoryService = CategoryService();
    final trackedCategories = categoryService.getCategoryStats();

    final progressMap = {
      for (final item in trackedCategories)
        item['category'].toString().toLowerCase(): (item['accuracy'] as num)
            .toDouble(),
    };

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.surface,
        title: Text(
          'Home',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 720 : width),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                isTablet ? 32 : 22,
                14,
                isTablet ? 32 : 22,
                24,
              ),
              itemCount: _defaultCategories.length + 2,
              separatorBuilder: (_, index) {
                if (index == 0) {
                  return const SizedBox(height: 22);
                }

                return const SizedBox(height: 4);
              },
              itemBuilder: (context, index) {
                // Logo
                if (index == 0) {
                  return const HomeLogoHeader();
                }

                // Section title
                if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Text(
                      'ALL TOPICS',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                }

                if (index == 0) return const HomeLogoHeader();

                if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Text(
                      'ALL TOPICS',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                }

                final category = _defaultCategories[index - 2];

                final progress = progressMap[category.toLowerCase()] ?? 0.0;

                return HomeCategoryTile(
                  category: category,
                  progress: progress,
                  icon: HomeCategoryMapper.iconFor(category),
                  color: HomeCategoryMapper.colorFor(category),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.practice,
                      arguments: category,
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
