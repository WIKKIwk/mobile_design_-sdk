import 'package:flutter/material.dart';
import 'm3_design.dart';
import 'apple_design.dart';

enum AppDesignStyle {
  material3,
  apple,
}

class DesignSDK {
  static AppDesignStyle currentStyle = AppDesignStyle.material3;

  /// Get the base theme dataset based on the current style.
  static ThemeData get theme {
    switch (currentStyle) {
      case AppDesignStyle.material3:
        return M3Design.theme;
      case AppDesignStyle.apple:
        return AppleDesign.theme;
    }
  }
}
