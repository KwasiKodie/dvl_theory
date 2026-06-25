import 'package:flutter/material.dart';
import '../../../../../core/theme/theme_controller.dart';

class ThemeSelector extends StatelessWidget {
  final ThemeController controller;

  const ThemeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RadioGroup<ThemeMode>(
      groupValue: controller.themeMode,
      onChanged: (ThemeMode? value) {
        if (value != null) {
          controller.changeThemeMode(value);
        }
      },
      child: Column(
        children: const [
          RadioListTile<ThemeMode>(
            value: ThemeMode.light,
            title: Text('Light Mode'),
            secondary: Icon(Icons.light_mode_outlined),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.dark,
            title: Text('Dark Mode'),
            secondary: Icon(Icons.dark_mode_outlined),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.system,
            title: Text('System Mode'),
            subtitle: Text('Follow device settings'),
            secondary: Icon(Icons.settings_suggest_outlined),
          ),
        ],
      ),
    );
  }
}
