import 'package:flutter/material.dart';

sealed class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.amber,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.amber,
  );
}
