import 'package:flutter/material.dart';

class AppControllers {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController homeListViewController = ScrollController();
  final ScrollController shoppingCartListViewController = ScrollController();
  final ScrollController productViewListViewController = ScrollController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController feedBackController = TextEditingController();
  void dispose() {
    shoppingCartListViewController.dispose();
    textEditingController.dispose();
    homeListViewController.dispose();
    productViewListViewController.dispose();
    fullNameController.dispose();
    feedBackController.dispose();
  }
}

class AuthController {
  static final AuthController _instance = AuthController._internal();

  factory AuthController() {
    return _instance;
  }

  AuthController._internal();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPassController = TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regPassController = TextEditingController();
  final TextEditingController regConfirmController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController parentCodeController = TextEditingController(text: 'D0001');
  void dispose() {
    lastNameController.dispose();
    firstNameController.dispose();
    loginEmailController.dispose();
    loginPassController.dispose();
    regPassController.dispose();
    regNumberController.dispose();
    parentCodeController.dispose();
  }
}

class PaymentMethodController {
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardIssueDateController = TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();
  void dispose() {
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    cardIssueDateController.dispose();
    cardCvvController.dispose();
  }
}

class PersonalInfoController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController zipCodeConroller = TextEditingController();
  final TextEditingController cityConroller = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    zipCodeConroller.dispose();
    phoneNumberController.dispose();
    cityConroller.dispose();
    addressController.dispose();
  }
}
