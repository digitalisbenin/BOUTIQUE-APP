
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:flutter/material.dart';

import '../../../config/helpers/input_controller/input_controller.dart';
import '../../../responsive/size_config.dart';
import '../../../utils/constants/app_colors/app_colors.dart';
import '../../widgets/input_field/input_field.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: const LargeText(
          largeTitle: "Add Address",
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfigs.screenHeight! * 0.03,
                    ),
                    OverflowBar(
                      overflowSpacing: SizeConfigs.screenHeight! * 0.01,
                      children: [
                        InputField(
                          bgColor: kWhiteColor,
                          label: "Name",
                          controller:
                              PersonalInfoController().fullNameController,
                        ),
                        InputField(
                          bgColor: kWhiteColor,
                          label: "Email address",
                          controller:
                              PersonalInfoController().addressController,
                        ),
                        InputField(
                          bgColor: kWhiteColor,
                          label: "Phone number",
                          controller:
                              PersonalInfoController().fullNameController,
                        ),
                        InputField(
                          bgColor: kWhiteColor,
                          label: "Address",
                          controller:
                              PersonalInfoController().addressController,
                        ),
                        InputField(
                          bgColor: kWhiteColor,
                          label: "Zip Code",
                          controller: PersonalInfoController().zipCodeConroller,
                        ),
                        InputField(
                          bgColor: kWhiteColor,
                          label: "City",
                          controller: PersonalInfoController().cityConroller,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SafeArea(
            child: PrimaryButton(
              buttonTitle: "Add Address",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
