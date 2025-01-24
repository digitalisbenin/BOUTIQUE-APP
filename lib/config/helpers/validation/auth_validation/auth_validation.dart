import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../presentation/pages/bottom_page/bottom_page.dart';
import '../../../../presentation/provider/app_provider.dart';
import '../../../router/app_route.dart';
import '../../input_controller/input_controller.dart';

class AuthValidation {
  void authLoginValidation({required BuildContext context}) {
    AuthController authController = AuthController();
    AppProvider appProvider = Provider.of(context, listen: false);
    String loginEmail = authController.loginEmailController.text;
    String loginPassController = authController.loginPassController.text;
    if (loginEmail.isEmpty && loginPassController.isEmpty) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile: "Tout les champs sont requis",
      );
    } else if (loginEmail.isEmpty) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile: "L'email est requis*",
      );
    } else if (loginPassController.isEmpty) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile: "Le mot de passe est requis*",
      );
    } else if (loginPassController.length < 6) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile: "Le mot de passe doit au moins avoir 6 caractères",
      );
    } else {
      AppRoutes.pushAndRemoveUntil(
        context,
        const BottomBarPage(),
      );
    }
  }

  void authRegisterValidation({required BuildContext context}) {
    AuthController authController = AuthController();
    AppProvider appProvider = Provider.of(context, listen: false);
    String regEmail = authController.regEmailController.text;
    String regPassController = authController.regPassController.text;

    String regConfirmController = authController.regConfirmController.text;
    // String regPhoneNumber = authController.regNumberController.text;

    if (regEmail.isEmpty &&
        regPassController.isEmpty &&
        regConfirmController.isEmpty) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile: "Tout les champs sont requis",
      );
    } else if (regEmail.isEmpty) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile: "L'email est requis*",
      );
    } else if (regPassController.isEmpty) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile: "Le mot de passe est requis*",
      );
    } else if (regPassController.length < 8) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile:
            "Le mot de passe doit au moins avoir une taille de 8 caratères",
      );
    }
    // else if (regPhoneNumber.isEmpty) {
    //   return appProvider.showSnackBar(
    //     context: context,
    //     snackBarTtile: "Le numéro de téléphone est requis*",
    //   )};
    // else if (regPhoneNumber.length != 13) {
    //   return appProvider.showSnackBar(
    //     context: context,
    //     snackBarTtile: "Le numéro de téléphone doit être de 11 caractères",
    //   );
    // }
     else if (regPassController != regConfirmController) {
      return appProvider.showSnackBar(
        context: context,
        snackBarTtile: "Les mots de passe sont différents",
      );
    } else {
      AppRoutes.pushAndRemoveUntil(
        context,
        const BottomBarPage(),
      );
      // /
    }
  }
}
