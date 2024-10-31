import 'package:flutter/material.dart';

class TBottomSheetTheme {
  // use private constructor
  TBottomSheetTheme._();

  // just to use static keyword

  // light theme
  static BottomSheetThemeData lightBottomTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints: BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  // Dark theme
  static BottomSheetThemeData darkBottomTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints: BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}
