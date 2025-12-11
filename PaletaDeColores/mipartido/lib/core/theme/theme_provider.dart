import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme mode options
enum AppThemeMode {
  light,
  dark,
  system,
}

/// Theme Provider
/// 
/// Manages theme mode selection and persistence
class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  
  AppThemeMode _themeMode = AppThemeMode.system;
  SharedPreferences? _prefs;
  
  AppThemeMode get themeMode => _themeMode;
  
  ThemeProvider() {
    _loadThemeMode();
  }
  
  /// Load saved theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    _prefs = await SharedPreferences.getInstance();
    final savedMode = _prefs?.getString(_themeKey);
    
    if (savedMode != null) {
      _themeMode = AppThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedMode,
        orElse: () => AppThemeMode.system,
      );
      notifyListeners();
    }
  }
  
  /// Set theme mode and persist to storage
  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    await _prefs?.setString(_themeKey, mode.toString());
    notifyListeners();
  }
  
  /// Convert AppThemeMode to Flutter ThemeMode
  ThemeMode get flutterThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
  
  /// Check if current theme is dark
  bool isDarkMode(BuildContext context) {
    if (_themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == AppThemeMode.dark;
  }
}
