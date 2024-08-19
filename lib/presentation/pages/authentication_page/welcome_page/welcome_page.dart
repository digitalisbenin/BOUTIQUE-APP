import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/register_page/register_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/singin_page/singin_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/social_btn.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/small_text.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/image_url/image_url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../responsive/size_config.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(secondIntro),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height / 2 - 20,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xffF4F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bienvenue sur Digit Shopping",
                        style: AppStyle.headlineSmall(context)!
                            .copyWith(fontFamily: "PoppinsSemiBold"),
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.005,
                      ),
                      const SmallText(
                        smallText:
                            "Bienvenue dans notre épicerie! Trouvez des produits frais et de qualité pour une expérience shopping agréable.",
                        color: Color(0xff868889),
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.005,
                      ),
                      SocialButton(
                        buttonTitle: "Continuer avec google",
                        onPressed: () {
                          /* AppRoutes.pushAndRemoveUntil(
                            context,
                            const BottomBarPage(),
                          ); */
                          Fluttertoast.showToast(
                              msg: "La connexion avec Google n'est pas encore disponible",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        socailIcon: "assets/icons/Google.svg",
                      ),
                      SocialButton(
                        buttonTitle: "Continuer avec Facebook",
                        onPressed: () {
                          /* AppRoutes.pushAndRemoveUntil(
                            context,
                            const BottomBarPage(),
                          ); */
                          Fluttertoast.showToast(
                              msg: "La connexion avec Facebook n'est pas encore disponible",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        socailIcon: "assets/icons/Facebook.svg",
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.01,
                      ),
                      PrimaryButton(
                        buttonTitle: "Créer un compte",
                        onPressed: () {
                          AppRoutes.pushToNextPage(
                            context,
                            const RegisterAccountPage(),
                          );
                        },
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MediumText(
                            middleTitle: 'Vous avez déjà un compte ?',
                            color: kLightBlackColor,
                            fontFamily: "PoppinsMedium",
                          ),
                          SizedBox(
                            width: SizeConfigs.screenWidth! * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              AppRoutes.pushToNextPage(
                                context,
                                const LoginPage(),
                              );
                            },
                            child: const MediumText(
                              middleTitle: "Se connecter",
                              fontFamily: "PoppinsSemiBold",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
