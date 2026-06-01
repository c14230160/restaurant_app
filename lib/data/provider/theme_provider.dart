import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeMode get themeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    _isDarkTheme = prefs.getBool('darkTheme') ?? false;

    notifyListeners();
  }

  Future<void> setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('darkTheme', value);

    _isDarkTheme = value;

    notifyListeners();
  }
}
