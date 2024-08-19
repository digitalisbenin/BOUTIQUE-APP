
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final String largeTitle;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  const LargeText({
    super.key,
    required this.largeTitle,
    this.fontFamily,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      largeTitle,
      style: AppStyle.titleLarge(context)!.copyWith(
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
