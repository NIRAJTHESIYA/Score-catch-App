import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'extrabold',
      color: Color(0xFF190B14),
    ),
    headlineMedium: TextStyle(
      fontFamily: 'bold',
      color: Color(0xFF190B14),
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Regular',
      color: Color(0xFF190B14),
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'extrabold',
      color: Color(0xFFD0C7C5),
    ),
    headlineMedium: TextStyle(
      fontFamily: 'bold',
      color: Color(0xFFD0C7C5),
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Regular',
      color: Color(0xFFD0C7C5),
    ),
  );
}
