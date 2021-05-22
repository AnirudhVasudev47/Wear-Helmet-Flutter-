import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear_helmet/global/color.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = ThemeMode.system == ThemeMode.dark ? true : false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: ThemeColors.primaryColorLight,
      accentColor: ThemeColors.accentColorLight,
      backgroundColor: ThemeColors.backgroundColorLight,
      scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColorLight,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: ThemeColors.headLineText1Light,
        ),
        headline2: TextStyle(
          color: ThemeColors.headLineText2Light,
        ),
        bodyText1: TextStyle(
          color: ThemeColors.bodyText1Light,
        ),
        bodyText2: TextStyle(
          color: ThemeColors.bodyText2Light,
        ),
      ),
      fontFamily: 'Poppins',
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: ThemeColors.primaryColorLight,
      accentColor: ThemeColors.accentColorLight,
      backgroundColor: ThemeColors.backgroundColorLight,
      scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColorLight,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: ThemeColors.headLineText1Dark,
        ),
        headline2: TextStyle(
          color: ThemeColors.headLineText2Dark,
        ),
        bodyText1: TextStyle(
          color: ThemeColors.bodyText1Dark,
        ),
        bodyText2: TextStyle(
          color: ThemeColors.bodyText2Dark,
        ),
      ),
      fontFamily: 'Poppins',
    );
  }
}
