import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF159FE3);
  static const Color darkNavy = Color(0xFF102A56);
  static const Color lightBlue = Color(0xFFEAF7FD);

  static ThemeData theme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: Colors.white,

    colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),

    appBarTheme: const AppBarTheme(
      backgroundColor: darkNavy,
      foregroundColor: Colors.white,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primaryBlue),
    ),
  );
}
