import 'package:flutter/material.dart';

class TColors {
  TColors._();

  // App BAsic Color
  static const Color primary = Color(0xFF4b68ff);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  // Text Color
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background Color
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Garident Color
  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.1),
      end: Alignment(0.707, -0.708),
      colors: [
        Color(0xffff9a9e),
        Color(0xfffad0c4),
        Color(0xfffad0c4),
      ]);

  // Button Color
  static const Color btnPrimary = Color(0xFF4b68FF);
  static const Color btnSecondary = Color(0xFF6C757D);
  static const Color disableBtn = Color(0xFFC4C4C4);
}
