import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/themes/custom_theme/checkbox_theme.dart';
import 'package:chat_app/core/utils/themes/custom_theme/text_theme.dart';

class TAppTheme {
  // for make constructor private
  TAppTheme._();

  // just becase of the use of Static keyword

  // Custom Theme Data for light
  static ThemeData lightMode = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue.shade100,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    checkboxTheme: TCheckboxTheme.lightCheckBoxTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
  );

// Custom Theme Data for Dark
  static ThemeData darkMode = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue.shade100,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.lightTextTheme,
  );
}
