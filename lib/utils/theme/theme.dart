import 'package:fdag/utils/theme/custom/appbar_theme.dart';
import 'package:fdag/utils/theme/custom/elevated_btn_theme.dart';
import 'package:fdag/utils/theme/custom/text_theme.dart';
import 'package:flutter/material.dart';

class ElAppTheme {
  // To avoid creating instances of this class
  ElAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: '',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: ElTextTheme.lightTheme,
    appBarTheme: ElAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: ElElevatedBtnTheme.lightElevatedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: '',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: ElTextTheme.darkTheme,
    appBarTheme: ElAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: ElElevatedBtnTheme.darlElevatedButtonTheme,
  );
}
