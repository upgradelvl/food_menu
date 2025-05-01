import 'package:flutter/material.dart';

class ThemeDataStyle {

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Color(0xFF409CDD),
      primary: Color(0xFF4CD1F5),
      secondary: Colors.deepPurple.shade300,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0xFF1F2C4C),
      primary: Color(0xFF4CD1F5),
      secondary: Colors.deepPurple.shade300,
    ),
  );

}