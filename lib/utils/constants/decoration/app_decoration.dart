import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';

class DecorationConstants {
  static BoxDecoration myDecoration = BoxDecoration(
    color: kWhiteColor,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1), // Set the shadow color
        spreadRadius: 3, // Set the spread radius of the shadow
        blurRadius: 8, // Set the blur radius of the shadow
        offset: const Offset(0, 3), // Set the offset of the shadow
      ),
    ],
  );
}
