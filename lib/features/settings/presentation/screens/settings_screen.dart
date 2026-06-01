import 'package:flutter/material.dart';

import '../../../../../core/theme/theme_controller.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../shared/navigation/app_bottom_navigation.dart';
import '../widgets/settings_tile.dart';
import '../widgets/theme_selector.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeController themeController;

  const SettingsScreen({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      appBar: AppBar(title: const Text('Settings'), centerTitle: false),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 720 : width),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? AppSpacing.xl : AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              children: [
                Text(
                  'Preferences',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SettingsTile(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  subtitle: 'Choose how DVLTheory appears on your device.',
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    child: AnimatedBuilder(
                      animation: themeController,
                      builder: (context, _) {
                        return ThemeSelector(controller: themeController);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
