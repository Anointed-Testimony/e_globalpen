import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF790679); // Purple
  static const Color secondaryColor = Color(0xFFFFDE59); // Yellow

  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}
