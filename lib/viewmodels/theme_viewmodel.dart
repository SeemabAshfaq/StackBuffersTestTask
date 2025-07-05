import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _userToggled = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    _userToggled = true;
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void resetToSystemTheme() {
    _userToggled = false;
    _themeMode = ThemeMode.system;
    notifyListeners();
  }

  void updateFromSystem() {
    if (!_userToggled) {
      _themeMode = ThemeMode.system;
      notifyListeners();
    }
  }
}
