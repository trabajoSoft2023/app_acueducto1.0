import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xff00B0BF);
  static final ThemeData ligthTheme = ThemeData.light().copyWith(
      primaryColor: Color(0xff00B0BF),
      appBarTheme: const AppBarTheme(color: Color(0xff00B0BF), elevation: 0));
}
