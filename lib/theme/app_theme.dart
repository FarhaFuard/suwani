import 'package:flutter/material.dart';

class AppTheme {
  static const Color navy = Color(0xFF172B4D);
  static const Color blue = Color(0xFF3268D5);
  static const Color muted = Color(0xFF7A8699);
  static const Color pageBackground = Color(0xFFF5F7FB);
  static const Color green = Color(0xFF20966B);
  static const Color coral = Color(0xFFE45F68);
  static const Color white = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: pageBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: blue,
        primary: blue,
        surface: white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: pageBackground,
        foregroundColor: navy,
        elevation: 0,
      ),
      fontFamily: 'Arial',
      cardTheme: CardThemeData(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}