import 'package:cricket/src/utils/theme/widget_theme/text_theme.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: lightColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: darkColor, // Set border color here
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: darkColor, // Set focused border color here
          width: 2.0,
        ),
      ),
      hintStyle: const TextStyle(color: darkColor),
      labelStyle: const TextStyle(color: darkColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColor, // Background color for ElevatedButton
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: AppTextTheme.darkTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: darkColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: lightColor, // Set border color here
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: lightColor, // Set focused border color here
          width: 2.0,
        ),
      ),
      hintStyle: const TextStyle(color: lightColor),
      labelStyle: const TextStyle(color: lightColor),
    ),
  );
}
