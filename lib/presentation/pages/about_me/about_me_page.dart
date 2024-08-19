import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/update_profile_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_code.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/user_model.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/singin_page/singin_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/input_field/input_field.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User? user;
  Code? code;
  bool loading = true;

  TextEditingController userNomController = TextEditingController();
  TextEditingController userPrenomController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userOldPasswordController = TextEditingController();

  // données de parainnage
  TextEditingController pointsController = TextEditingController();
  TextEditingController codeParentController = TextEditingController();
  TextEditingController codeParainnageUserController = TextEditingController();

  // bonus
  TextEditingController bonusUserController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserInfo();
    getUserCode();
  }

  void getUserInfo() async {
    ApiResponse apiResponse = await getUser();

    if (apiResponse.error == null) {
      setState(() {
        user = apiResponse.data as User;
        userNomController.text = user?.nom ?? '';
        userPrenomController.text = user?.prenoms ?? '';
        userEmailController.text = user?.email ?? '';
        userPhoneController.text = user?.phoneNumber ?? '';

        pointsController.text = user!.points.toString();
        codeParentController.text = user?.codeParents ?? '';

        loading = false;
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${apiResponse.error}')));
    }
  }

  void getUserCode() async {
    ApiResponse apiResponse = await getInscriptionInfo();

    if (apiResponse.error == null) {
      setState(() {
        code = apiResponse.data as Code;
        codeParainnageUserController.text = code?.codeUser ?? '';
        bonusUserController.text = code!.bonus.toString();

        loading = false;
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${apiResponse.error}')));
    }
  }

  void _updateUserProfile(nom, prenom, email, phoneNumber, currentPassword,
      newPassword, confirmNewPassword) async {
    setState(() {
      loading = true;
    });
    ApiResponse response = await updateProfile(nom, prenom, email, phoneNumber,
        currentPassword, newPassword, confirmNewPassword);

    setState(() {
      loading = false;
    });

    if (response.error != null) {
      getUserInfo();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Les informations ont été mises à jour avec succès !")));
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
        backgroundColor: kWhiteColor,
        title: const LargeText(
          largeTitle: "Sur moi",
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: OverflowBar(
                          overflowSpacing: 10,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.03,
                            ),LargeText(
                              largeTitle:
                                  "Points de parainnage: ${pointsController.text} points",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.002,
                            ),
                            LargeText(
                              largeTitle:
                                  "Bonus d'achat actuel: ${bonusUserController.text} FCFA",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.002,
                            ),
                            const Divider(
                              color: kCupertinoModalBarrierColor,
                            ),
                            const LargeText(
                              largeTitle: "Données de parainnage",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.002,
                            ),
                            Container(
                              height: SizeConfigs.screenHeight! * 0.07,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                readOnly: true,
                                controller: codeParentController,
                                style: const TextStyle(color: Colors.grey),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  hintText: "Code Parents",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.002,
                            ),
                            Container(
                              height: SizeConfigs.screenHeight! * 0.07,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      readOnly: true,
                                      controller: codeParainnageUserController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        hintText: "Code de parainnage",
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: codeParainnageUserController
                                                .text
                                                .toString()));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Le code a été copié dans le presse-papier')),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.copy,
                                        color: kPrimaryColor,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.002,
                            ),
                            const LargeText(
                              largeTitle: "Détails personnels",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.002,
                            ),
                            InputField(
                              bgColor: kWhiteColor,
                              label: "NOM",
                              controller: userNomController,
                            ),
                            InputField(
                              bgColor: kWhiteColor,
                              label: "Prénom(s)",
                              controller: userPrenomController,
                            ),
                            InputField(
                              bgColor: kWhiteColor,
                              label: "abc@gmail.com",
                              controller: userEmailController,
                            ),
                            InputField(
                              bgColor: kWhiteColor,
                              label: "Numéro de téléphone",
                              controller: userPhoneController,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: OverflowBar(
                          overflowSpacing: 10,
                          children: [
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.03,
                            ),
                            const LargeText(
                              largeTitle: "Changer le mot de passe",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: SizeConfigs.screenHeight! * 0.002,
                            ),
                            InputField(
                              bgColor: kWhiteColor,
                              label: "Mot de passe actuel",
                              controller: userOldPasswordController,
                            ),
                            PassWordInput(
                              controller: userPasswordController,
                              text: "Nouveau mot de passe",
                            ),
                            PassWordInput(
                              controller: userPasswordController,
                              text: "Confirmer le mot de passe",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PrimaryButton(
                          buttonTitle: "Sauvegarder",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              _updateUserProfile(
                                  userNomController.text,
                                  userPrenomController.text,
                                  userEmailController.text,
                                  userPhoneController.text,
                                  userOldPasswordController.text,
                                  userPasswordController.text,
                                  userPasswordController.text);
                            } else if (userNomController.text.isEmpty ||
                                userPrenomController.text.isEmpty ||
                                userEmailController.text.isEmpty ||
                                userPhoneController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                      content: Text(
                                        'Vérifier si le/les champ(s) que vous souhaitez modifier sont au moins renseigné, sans quoi, la modification ne pourrait aboutir.',
                                        style: TextStyle(color: kWhiteColor),
                                      )));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
