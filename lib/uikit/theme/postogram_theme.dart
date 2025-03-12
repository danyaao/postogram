import 'package:flutter/material.dart';

abstract final class PostogramThemeData {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black),
    scaffoldBackgroundColor: Colors.white,
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white),
    scaffoldBackgroundColor: Colors.black,
  );
}
