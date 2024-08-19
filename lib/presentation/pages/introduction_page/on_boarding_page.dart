
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/welcome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/router/app_route.dart';
import '../../../config/theme/app_style/app_style.dart';
import '../../../domain/models/intro_model.dart';
import '../../../responsive/size_config.dart';
import '../../../utils/constants/app_colors/app_colors.dart';
import '../../widgets/app_btn/app_text_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late double _width = MediaQuery.of(context).size.width / 3;
  int _imageIndex = 0;

  void next() {
    if (_width < MediaQuery.of(context).size.width) {
      setState(() {
        _width += MediaQuery.of(context).size.width / 3;
        _imageIndex = (_imageIndex + 1) % introPageList.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            SizedBox(
              width: double.infinity,
              height: SizeConfigs.screenHeight! * 0.3,
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: SvgPicture.asset(
                    key:
                        ValueKey<String>(introPageList[_imageIndex].introImage),
                    introPageList[_imageIndex].introImage,
                  )),
            ),
            const Spacer(),
            SafeArea(
              child: OverflowBar(
                overflowSpacing: SizeConfigs.screenHeight! * 0.04,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      introPageList[_imageIndex].introTitle,
                      textAlign: TextAlign.center,
                      style: AppStyle.displayLarge(context)!.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      introPageList[_imageIndex].introDecription,
                      textAlign: TextAlign.center,
                      style: AppStyle.bodyMedium(context)!.copyWith(
                        color: kLightBlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 5,
                        width: SizeConfigs.screenWidth!,
                        color: kPrimaryColor.withOpacity(0.2),
                      ),
                      AnimatedContainer(
                        width: _width,
                        height: 5,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextButton(
                        btnTitle: "Passer",
                        onPressed: () {
                          AppRoutes.pushAndRemoveUntil(
                            context,
                            const WelcomePage(),
                          );
                        },
                      ),
                      _imageIndex != 2
                          ? AppTextButton(
                              btnTitle: "Suivant",
                              onPressed: next,
                            )
                          : AppTextButton(
                              btnTitle: "Commencer",
                              onPressed: () {
                                AppRoutes.pushAndRemoveUntil(
                                  context,
                                  const WelcomePage(),
                                );
                              },
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
