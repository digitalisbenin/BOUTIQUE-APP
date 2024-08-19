
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String smallText;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  const SmallText({
    super.key,
    required this.smallText,
    this.fontFamily,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      smallText,
      style: AppStyle.titleSmall(context)!.copyWith(
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
