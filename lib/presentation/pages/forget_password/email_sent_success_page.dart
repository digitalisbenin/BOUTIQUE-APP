import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/singin_page/singin_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/input_field/input_field.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class EmailSentSuccessPage extends StatefulWidget {
  const EmailSentSuccessPage({super.key});

  @override
  State<EmailSentSuccessPage> createState() => _EmailSentSuccessPageState();
}

class _EmailSentSuccessPageState extends State<EmailSentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Réinitialisation de mot de passe"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Email envoyé",
                  textAlign: TextAlign.center,
                  style: AppStyle.headlineLarge(context)!.copyWith(),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.02,
                ),
                Text(
                  "Un email vous a été envoyé. Veuillez consulter votre boite de reception pour continuer le processus de réinitialisation du mot de passe",
                  textAlign: TextAlign.center,
                  style: AppStyle.bodyLarge(context)!.copyWith(
                    color: kLightBlackColor,
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  child: PrimaryButton(
                    buttonTitle: "Connexion",
                    onPressed: () {
                      AppRoutes.pushAndRemoveUntil(context, const LoginPage());
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
