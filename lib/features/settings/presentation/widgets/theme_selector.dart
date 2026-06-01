import 'package:flutter/material.dart';
import '../../../../../core/theme/theme_controller.dart';

class ThemeSelector extends StatelessWidget {
  final ThemeController controller;

  const ThemeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<ThemeMode>(
          value: ThemeMode.light,
          groupValue: controller.themeMode,
          title: const Text('Light Mode'),
          secondary: const Icon(Icons.light_mode_outlined),
          onChanged: (value) {
            if (value != null) controller.changeThemeMode(value);
          },
        ),
        RadioListTile<ThemeMode>(
          value: ThemeMode.dark,
          groupValue: controller.themeMode,
          title: const Text('Dark Mode'),
          secondary: const Icon(Icons.dark_mode_outlined),
          onChanged: (value) {
            if (value != null) controller.changeThemeMode(value);
          },
        ),
        RadioListTile<ThemeMode>(
          value: ThemeMode.system,
          groupValue: controller.themeMode,
          title: const Text('System Mode'),
          subtitle: const Text('Follow device settings'),
          secondary: const Icon(Icons.settings_suggest_outlined),
          onChanged: (value) {
            if (value != null) controller.changeThemeMode(value);
          },
        ),
      ],
    );
  }
}
