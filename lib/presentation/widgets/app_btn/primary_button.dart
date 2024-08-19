
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:flutter/material.dart';

import '../../../responsive/size_config.dart';
import '../../../utils/constants/app_colors/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonTitle;

  const PrimaryButton({
    Key? key,
    required this.buttonTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return SizedBox(
      width: SizeConfigs.screenWidth! - 20,
      height: SizeConfigs.screenHeight! * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: LargeText(
          largeTitle: buttonTitle,
          color: kWhiteColor,
        ),
      ),
    );
  }
}
