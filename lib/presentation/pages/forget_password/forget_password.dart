import 'package:digitalis_shop_grocery_app/config/helpers/input_controller/input_controller.dart';
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/forgot_password_service.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/forget_password/email_sent_success_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/input_field/input_field.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userEmailController = TextEditingController();
  bool loading = true;

  void _changePassword(userEmail) async {
    setState(() {
      loading = true;
    });
    ApiResponse response = await changePassword(userEmail);

    setState(() {
      loading = false;
    });
    print(response);
    if (response.error == "Aucun utilisateur n'a été trouvé avec cette adresse e-mail") {
              ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${response.error}")));
              
    } else if (response.error == "Nous vous avons envoyé par mail le lien de réinitialisation du mot de passe !") {
      AppRoutes.pushAndRemoveUntil(context, const EmailSentSuccessPage());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email envoyé")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }

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
                  "Mot de passe oublié",
                  textAlign: TextAlign.center,
                  style: AppStyle.headlineLarge(context)!.copyWith(),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.02,
                ),
                Text(
                  "Mot de passe oublié? Aucun problème! Réinitialisez-le ici et retrouvez l'accès à votre compte.",
                  textAlign: TextAlign.center,
                  style: AppStyle.bodyLarge(context)!.copyWith(
                    color: kLightBlackColor,
                  ),
                )
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: SizeConfigs.screenWidth! - 25,
                    child: InputField(
                      bgColor: kWhiteColor,
                      label: "Adresse Email",
                      controller: userEmailController,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfigs.screenHeight! * 0.02,
                  ),
                  PrimaryButton(
                    buttonTitle: "Envoyer",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (userEmailController.text.isNotEmpty) {
                          _changePassword(userEmailController.text);
                        } else { 
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "L'adresse email est requise pour continuer"),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ));
                        }
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
