import 'package:flutter/material.dart';

const kScaffoldColor = Color(0xffF4F5F9);
Color kGrey = const Color(0xff858889);
const Color kBlackColor = Colors.black;
Color kLightBlackColor = Colors.black.withOpacity(0.5);
const Color kWhiteColor = Colors.white;
Color kLightWhiteColor = Colors.white.withOpacity(0.5);
const Color kOragneColor = Color(0xff15a84a);
const Color kPrimaryColor = Color(0xff15a84a);
Gradient kGradientColor = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kOragneColor,
    kPrimaryColor,
  ],
);

MaterialColor materialPrimaryColor = const MaterialColor(
  0xff15a84a, // Replace with your desired color value
  <int, Color>{
    50: Color(0xff15a84a),
    100: Color(0xff15a84a),
    200: Color(0xff15a84a),
    300: Color(0xff15a84a),
    400: Color(0xff15a84a),
    500: Color(0xff15a84a),
    600: Color(0xff15a84a),
    700: Color(0xff15a84a),
    800: Color(0xff15a84a),
    900: Color(0xff15a84a),
  },
);

final colorScheme = ColorScheme.fromSwatch(
  primarySwatch: const MaterialColor(0xff15a84a, {
    50: Color(0xff15a84a),
    100: Color(0xff15a84a),
    200: Color(0xff15a84a),
    300: Color(0xff15a84a),
    400: Color(0xff15a84a),
    500: Color(0xff15a84a),
    600: Color(0xff15a84a),
    700: Color(0xff15a84a),
    800: Color(0xff15a84a),
    900: Color(0xff15a84a),
  }),
);
