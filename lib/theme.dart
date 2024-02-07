// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class XgenriaTheme {
  static final dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF916BFF),
      secondary: Color(0xFF5C99FF),
      background: Color(0xFF151618),
      tertiary: Color(0xFFFF3267),
      tertiaryContainer: Color(0xFFFFD6E2),
      surfaceTint: Color(0xFF252525),
      onSurfaceVariant: Colors.grey,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
        titleMedium: TextStyle(fontSize: 24, decoration: TextDecoration.none),
        bodyMedium: TextStyle(fontSize: 16, decoration: TextDecoration.none),
        bodySmall: TextStyle(fontSize: 14, decoration: TextDecoration.none)),
  );
}
