
import 'package:digitalis_shop_grocery_app/config/helpers/input_controller/input_controller.dart';
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/user_orders/order_successfully/order_successfully.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/input_field/input_field.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/small_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/static_data/icons_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: const Text("Shipping Address"),
      ),
      body: const HorizontalStepper(),
    );
  }
}

class HorizontalStepper extends StatefulWidget {
  const HorizontalStepper({super.key});

  @override
  State<HorizontalStepper> createState() => _HorizontalStepperState();
}

class _HorizontalStepperState extends State<HorizontalStepper> {
  int _currentStep = 0;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Column(
      children: [
        Expanded(
          child: Stepper(
            margin: EdgeInsets.zero,
            type: StepperType.horizontal,
            physics: const ScrollPhysics(),
            currentStep: _currentStep,
            onStepTapped: (step) => tapped(step),
            onStepCancel: cancel,
            controlsBuilder: (context, _) {
              return SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfigs.screenHeight! * 0.15,
                    ),
                    _currentStep < 1
                        ? PrimaryButton(
                            buttonTitle: "Next",
                            onPressed: continued,
                          )
                        : PrimaryButton(
                            buttonTitle: "Make a Payment",
                            onPressed: () {
                              /* AppRoutes.pushToNextPage(
                                context,
                                const OrderSuccessfully(),
                              ); */
                            },
                          )
                  ],
                ),
              );
            },
            steps: <Step>[
              Step(
                title: const Text(''),
                content: OverflowBar(
                  overflowSpacing: SizeConfigs.screenHeight! * 0.01,
                  children: [
                    /* InputField(
                      bgColor: kWhiteColor,
                      label: "Name",
                      controller: PersonalInfoController().fullNameController,
                    ),
                    InputField(
                      bgColor: kWhiteColor,
                      label: "Email Address",
                      controller: PersonalInfoController().emailController,
                    ), */
                     InputField(
                      bgColor: kWhiteColor,
                      label: "Adresse",
                      controller: PersonalInfoController().addressController,
                    ),
                    InputField(
                      bgColor: kWhiteColor,
                      label: "Téléphone",
                      controller:
                          PersonalInfoController().phoneNumberController,
                    ),
                   /* 
                    InputField(
                      bgColor: kWhiteColor,
                      label: "Zip Code",
                      controller: PersonalInfoController().zipCodeConroller,
                    ),
                    InputField(
                      bgColor: kWhiteColor,
                      label: "City",
                      controller: PersonalInfoController().cityConroller,
                    ), */
                  ],
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: const Text(''),
                content: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: SizeConfigs.screenHeight! * 0.15,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedIndex == 0
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    kkiapay,
                                    height: 50,
                                  ),
                                  const SmallText(
                                    smallText: "Kkiapay",
                                    fontFamily: "PoppinsSemiBold",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth! * 0.02,
                        ),
                        Expanded(
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: SizeConfigs.screenHeight! * 0.15,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedIndex == 0
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    paypal,
                                    height: 50,
                                  ),
                                  const SmallText(
                                    smallText: "Papal",
                                    fontFamily: "PoppinsSemiBold",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth! * 0.02,
                        ),
                        Expanded(
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: SizeConfigs.screenHeight! * 0.15,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedIndex == 2
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    applePay,
                                    height: 50,
                                    color: kGrey,
                                  ),
                                  const SmallText(
                                    smallText: "Apple Pay",
                                    fontFamily: "PoppinsSemiBold",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfigs.screenHeight! * 0.05,
                    ),
                    OverflowBar(
                      overflowSpacing: SizeConfigs.screenHeight! * 0.01,
                      children: [
                        InputField(
                          bgColor: kWhiteColor,
                          label: "Name On The Card",
                          controller: PaymentMethodController()
                              .cardHolderNameController,
                        ),
                        InputField(
                          bgColor: kWhiteColor,
                          label: "Card Number",
                          controller:
                              PaymentMethodController().cardNumberController,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InputField(
                                bgColor: kWhiteColor,
                                label: "Month/Year",
                                controller: PaymentMethodController()
                                    .cardIssueDateController,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfigs.screenWidth! * 0.02,
                            ),
                            Expanded(
                              child: InputField(
                                bgColor: kWhiteColor,
                                label: "CVV",
                                controller:
                                    PaymentMethodController().cardCvvController,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
            ],
          ),
        ),
      ],
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 1 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
