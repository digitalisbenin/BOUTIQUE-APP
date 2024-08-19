import 'package:flutter/material.dart';
import '../../../config/theme/app_style/app_style.dart';
import '../../../utils/constants/app_colors/app_colors.dart';

class AppTextButton extends StatelessWidget {
  final Function() onPressed;
  final String btnTitle;
  const AppTextButton({
    super.key,
    required this.btnTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnTitle,
        style: AppStyle.titleMedium(context)!.copyWith(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
