
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonTitle;
  final String socailIcon;
  const SocialButton(
      {super.key,
      required this.buttonTitle,
      required this.onPressed,
      required this.socailIcon});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: SizeConfigs.screenHeight! * 0.07,
      width: SizeConfigs.screenWidth! - 20,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: kWhiteColor,
          side: BorderSide.none,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        icon: SvgPicture.asset(
          socailIcon,
          color: kBlackColor,
          height: 30,
        ),
        label: MediumText(
          middleTitle: buttonTitle,
        ),
      ),
    );
  }
}
