import 'package:digitalis_shop_grocery_app/config/helpers/input_controller/input_controller.dart';
import 'package:digitalis_shop_grocery_app/config/helpers/validation/auth_validation/auth_validation.dart';
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/user_model.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/register_page/register_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/bottom_page/bottom_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/forget_password/forget_password.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/input_field/input_field.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/small_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/image_url/image_url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthValidation authValidation = AuthValidation();
  AuthController authController = AuthController();

  bool loading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _loginUser() async {
    ApiResponse response = await login(authController.loginEmailController.text,
        authController.loginPassController.text);
    print('login message ::: ${response.error}');
    if (response.error == 'Connecté avec succès') {
      _saveAndRedirectToHome(response.data as User);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ));
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", user.token ?? '');
    await pref.setInt("userid", user.id ?? 0);
    AppRoutes.pushAndRemoveUntil(
      context,
      const BottomBarPage(),
    );
  }
    @override
  void dispose() {
    super.dispose();
    authController.loginEmailController.clear();
    authController.loginPassController.clear();
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
                    image: AssetImage(secondIntro),
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
                      "Content de vous revoir!",
                      style: AppStyle.headlineSmall(context)!
                          .copyWith(fontFamily: "PoppinsSemiBold"),
                    ),
                    const SmallText(
                      smallText: "Connectez-vous à votre compte",
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
                            controller: authController.loginEmailController,
                            label: "Adresse Email",
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight! * 0.01,
                          ),
                          PassWordInput(
                            controller: authController.loginPassController,
                            text: "Mot de passe",
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                AppRoutes.pushToNextPage(
                                  context,
                                  const ForgetPassword(),
                                );
                              },
                              child: const MediumText(
                                middleTitle: "Mot de passe oublié",
                                color: kPrimaryColor,
                                fontFamily: "PoppinsSemiBold",
                              ),
                            ),
                          ),
                          PrimaryButton(
                            buttonTitle: "Se connecter",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                  _loginUser();
                                });
                              } else {
                                authValidation.authLoginValidation(
                                    context: context);
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
                          middleTitle: "Vous n'avez pas de compte ?",
                          color: kLightBlackColor,
                          fontFamily: "PoppinsMedium",
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth! * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            AppRoutes.pushAndRemoveUntil(
                              context,
                              const RegisterAccountPage(),
                            );
                          },
                          child: const MediumText(
                            middleTitle: "S'inscrire",
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
