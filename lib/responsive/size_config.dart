import 'package:flutter/material.dart';

class SizeConfigs {
  // SizeConfigs is seprate class for using media Qury to project
  //  SizeConfigs is required to add inside of build class like this  SizeConfigs().init(context);
  //  otherwise u get the error of null type
  // how to use SizeConfigs.screenHeight! * 0.32
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
  }
}
