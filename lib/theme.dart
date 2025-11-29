import 'package:flutter/material.dart';

final ThemeData temaIce = ThemeData(
  primaryColor: Colors.cyan,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.cyan,
    primary: Colors.cyan,
    secondary: Colors.white70,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.cyan,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.cyan,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.cyan,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.cyan),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.cyan, width: 2),
    ),
    labelStyle: const TextStyle(color: Colors.cyan),
    floatingLabelStyle: const TextStyle(color: Colors.cyan),
  ),
  cardTheme: CardThemeData(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
