import 'package:digitalis_shop_grocery_app/config/helpers/input_controller/input_controller.dart';
import 'package:digitalis_shop_grocery_app/config/helpers/validation/auth_validation/auth_validation.dart';
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/singin_page/singin_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/input_field/input_field.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/small_text.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/image_url/image_url.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/app_style/app_style.dart';
import '../../../../responsive/size_config.dart';

class RegisterAccountPage extends StatefulWidget {
  const RegisterAccountPage({super.key});

  @override
  State<RegisterAccountPage> createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  AuthValidation authValidation = AuthValidation();
  AuthController authController = AuthController();

  bool loading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _registerUser() async {
    ApiResponse response = await register(
        authController.lastNameController.text,
        authController.firstNameController.text,
        authController.parentCodeController.text,
        authController.regEmailController.text,
        authController.regPassController.text,
        authController.regConfirmController.text);

    print('reponse ${response.data}');
    print('reponse ${response.error}');

    if (response.error == "Something went wrong, try again") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Inscription réussi"), backgroundColor: Colors.green));
      AppRoutes.pushToNextPage(context, const LoginPage());
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    authController.lastNameController.clear();
    authController.firstNameController.clear();
    // authController.parentCodeController.clear();
    authController.regEmailController.clear();
    authController.regPassController.clear();
    authController.regConfirmController.clear();
  }

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
                    image: AssetImage(thirdIntro),
                  ),
                ),
                child: const SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          color: kWhiteColor,
                        ),
                        LargeText(
                          largeTitle: "Bienvenue",
                          color: kWhiteColor,
                          fontFamily: "PoppinsSemiBold",
                        ),
                        SizedBox()
                      ],
                    ),
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
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Text(
                      "Créer un compte",
                      style: AppStyle.headlineSmall(context)!
                          .copyWith(fontFamily: "PoppinsSemiBold"),
                    ),
                    const SmallText(
                      smallText: "Créez rapidement un compte",
                      color: Color(0xff868889),
                    ),
                    SizedBox(
                      height: SizeConfigs.screenHeight! * 0.03,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          InputField(
                            bgColor: kWhiteColor,
                            label: "Nom",
                            controller: authController.lastNameController,
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight! * 0.01,
                          ),
                          InputField(
                            bgColor: kWhiteColor,
                            label: "Prénom(s)",
                            controller: authController.firstNameController,
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight! * 0.01,
                          ),
                          InputField(
                            bgColor: kWhiteColor,
                            label: "Code Parent",
                            controller: authController.parentCodeController,
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight! * 0.01,
                          ),
                          InputField(
                            bgColor: kWhiteColor,
                            label: "Adresse Email",
                            controller: authController.regEmailController,
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight! * 0.01,
                          ),
                          PassWordInput(
                            controller: authController.regPassController,
                            text: "Mot de passe",
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight! * 0.01,
                          ),
                          PassWordInput(
                            controller: authController.regConfirmController,
                            text: "Confirmer le mot de passe",
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight! * 0.03,
                          ),
                          PrimaryButton(
                            buttonTitle: "S'inscrire",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (authController.lastNameController.text.isEmpty ||
                                    authController
                                        .firstNameController.text.isEmpty ||
                                    authController
                                        .parentCodeController.text.isEmpty ||
                                    authController
                                        .regEmailController.text.isEmpty ||
                                    authController
                                        .regPassController.text.isEmpty) {
                                  authValidation.authRegisterValidation(
                                    context: context,
                                  );
                                } else {
                                  setState(() {
                                    loading = true;
                                    _registerUser();
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
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
            )
          ],
        ),
      ),
    );
  }
}
