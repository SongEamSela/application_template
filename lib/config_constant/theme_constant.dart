import 'package:flutter/material.dart';

class ThemeConstant {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xFF2c5918),
      ),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
        elevation: 0.5,
        actionsIconTheme: iconTheme(),
        iconTheme: iconTheme(),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20));
  }

  static IconThemeData iconTheme() {
    return const IconThemeData(
      color: Colors.black,
    );
  }

  static AppBar hideAppBar() {
    return AppBar(
      iconTheme: iconTheme(),
      elevation: 0,
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
    );
  }
}
