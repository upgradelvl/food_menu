import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'thema_data_style.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeDataStyle;

  ThemeProvider({required bool isDark})
      : _themeDataStyle = isDark ? ThemeDataStyle.dark : ThemeDataStyle.light;

  ThemeData get themeDataStyle => _themeDataStyle;


  void changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (_themeDataStyle == ThemeDataStyle.light) {
      _themeDataStyle = ThemeDataStyle.dark;
      await prefs.setBool('isDark', true);
    } else {
      _themeDataStyle = ThemeDataStyle.light;
      await prefs.setBool('isDark', false);
    }
    notifyListeners();
  }
}
