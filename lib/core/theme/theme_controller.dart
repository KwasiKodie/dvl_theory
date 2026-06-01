import 'package:flutter/material.dart';
import 'theme_mode_storage.dart';

class ThemeController extends ChangeNotifier {
  final ThemeModeStorage _storage;

  ThemeController({required ThemeModeStorage storage}) : _storage = storage;

  ThemeMode _themeMode = ThemeMode.system;
  bool _initialized = false;

  ThemeMode get themeMode => _themeMode;
  bool get initialized => _initialized;

  Future<void> initialize() async {
    _themeMode = await _storage.loadThemeMode();
    _initialized = true;
    notifyListeners();
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    await _storage.saveThemeMode(mode);
  }
}
