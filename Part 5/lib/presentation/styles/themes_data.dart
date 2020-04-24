import 'package:flutter/material.dart' hide Theme;
import 'package:bloc_example/models/theme.dart';

final themesData = {
  Theme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.grey[700],
    textTheme: TextTheme(
      body1: TextStyle(color: Colors.grey[700]),
    ),
  ),
  Theme.dark: ThemeData(
    brightness: Brightness.dark,
  ),
};
