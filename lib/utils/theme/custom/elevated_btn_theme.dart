import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/commons/colors/sizes.dart';
import 'package:flutter/material.dart';

class ElElevatedBtnTheme {
  // To avoid creating instances of this class
  ElElevatedBtnTheme._();

  // Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: ElColor.transparent,
      disabledBackgroundColor: ElColor.darkBlue200,
      disabledForegroundColor: ElColor.darkBlue200,
      side: BorderSide(color: ElColor.darkBlue),
      padding: EdgeInsets.all(Sizes.f001),
      textStyle: TextStyle(
          fontSize: Sizes.fontSizeSm,
          color: Colors.black,
          fontWeight: FontWeight.w600),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.f4)),
    ),
  );

  // Dark Theme
  static final darlElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: BorderSide(color: Colors.blue),
      padding: EdgeInsets.symmetric(vertical: 18.0),
      textStyle: TextStyle(
          fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
