import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppleDesign {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: CupertinoColors.activeBlue,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: CupertinoColors.systemGroupedBackground,
        foregroundColor: CupertinoColors.black,
      ),
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}
