// ignore: file_names
import 'package:flutter/material.dart';

class TElevatedBtnTheme {
  // use private constructor
  TElevatedBtnTheme._();

  // just to use static keyword

  // light theme
  static final ElevatedButtonThemeData lightModelBtn =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent.shade200,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey.shade300,
          side: BorderSide(color: Colors.blueAccent.shade200),
          padding: EdgeInsets.symmetric(vertical: 18),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        )
      );

      // Dark Btn theme
      static final ElevatedButtonThemeData darkModelBtn =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey.shade300,
          side: BorderSide(color: Colors.blueAccent.shade200),
          padding: EdgeInsets.symmetric(vertical: 18),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        )
      );
}
