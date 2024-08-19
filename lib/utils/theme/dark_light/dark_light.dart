import 'package:flutter/material.dart';

import '../../../config/theme/app_style/app_style.dart';
import '../../constants/app_colors/app_colors.dart';

class AppTheme {
  static ThemeData? lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: kPrimaryColor,
      fontFamily: 'PoppinsRegular',
      scaffoldBackgroundColor: kScaffoldColor,
      primarySwatch: materialPrimaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: kPrimaryColor,
        background: kWhiteColor,
        primary: kPrimaryColor,
      ),
      useMaterial3: true,
      iconTheme: const IconThemeData(color: kBlackColor),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: kBlackColor),
        bodyLarge: TextStyle(fontSize: 16, color: kBlackColor),
        labelLarge: TextStyle(fontSize: 16, color: kBlackColor),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: kScaffoldColor,
        elevation: 0,
        titleTextStyle: AppStyle.titleLarge(context),
        iconTheme: const IconThemeData(color: kBlackColor),
      ),
    );
  }

  static final ThemeData darkTheme = ThemeData(
    primaryColor: kPrimaryColor,
    fontFamily: 'PoppinsRegular',
    useMaterial3: true,
    iconTheme: const IconThemeData(color: kBlackColor),
    primarySwatch: materialPrimaryColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      labelLarge: TextStyle(fontSize: 16, color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: kBlackColor),
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
