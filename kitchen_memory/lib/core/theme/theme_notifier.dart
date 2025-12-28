import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

class ThemeNotifier extends ChangeNotifier {
  static const _prefKey = "app_theme_mode";
  static String _currentThemeName = "Light";

  AppThemeMode _currentThemeMode = AppThemeMode.system;
  //system, dark, light are 3 options to choose from

  AppThemeMode get currentThemeMode => _currentThemeMode;
  String get currentThemeName => _currentThemeName;
  bool get isDark => _currentThemeMode == AppThemeMode.dark;

  ThemeMode getMaterialThemeMode() {
    switch (_currentThemeMode) {
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.light:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeNotifier() {
    _loadFromPreferences();
  }

  Future<void> _loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_prefKey);

    if (value != null) {
      for (final mode in AppThemeMode.values) {
        if (mode.toString() == value) {
          _currentThemeMode = mode;
          break;
        }
      }
    }

    _currentThemeName = "Light";

    notifyListeners();
  }

  Future<void> setMode(AppThemeMode newMode) async {
    _currentThemeMode = newMode;

    //since the mode is changed we need to update it in shared preferences
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(_prefKey, newMode.toString());

    if (newMode == AppThemeMode.light) {
      _currentThemeName = "Light";
    } else {
      _currentThemeName = "Dark";
    }

    notifyListeners();
  }
}
