
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/my_address/add_address.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/small_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/helpers/input_controller/input_controller.dart';
import '../../../utils/constants/static_data/icons_data.dart';
import '../../widgets/input_field/input_field.dart';

class MyAddress extends StatelessWidget {
  const MyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: const LargeText(largeTitle: "My Address"),
        actions: [
          IconButton(
            splashRadius: 24,
            onPressed: () {
              AppRoutes.pushToNextPage(
                context,
                const AddAddress(),
              );
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              SizedBox(
                height: SizeConfigs.screenHeight! * 0.01,
              ),
              const MyAddressWidget(),
              const MyAddressWidget(),
              const MyAddressWidget(),
            ],
          ),
          SafeArea(
            child: PrimaryButton(
              buttonTitle: "Save Setting",
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

class MyAddressWidget extends StatefulWidget {
  const MyAddressWidget({super.key});

  @override
  State<MyAddressWidget> createState() => _MyAddressWidgetState();
}

class _MyAddressWidgetState extends State<MyAddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: kWhiteColor,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          child: ExpansionTile(
            backgroundColor: kWhiteColor,
            shape: const Border(),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: kPrimaryColor.withOpacity(0.1),
              child: SvgPicture.asset(
                homeLocation,
                color: kPrimaryColor,
              ),
            ),
            title: const LargeText(largeTitle: "The Flutter Pro"),
            subtitle: SmallText(
              smallText:
                  '2811 Crescent Day. LA Port California, United States 77571',
              color: kLightBlackColor,
            ),
            tilePadding: const EdgeInsets.all(24),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              OverflowBar(
                overflowSpacing: SizeConfigs.screenHeight! * 0.01,
                children: [
                  InputField(
                    bgColor: kScaffoldColor,
                    label: "Name",
                    controller: PersonalInfoController().fullNameController,
                  ),
                  InputField(
                    bgColor: kScaffoldColor,
                    label: "Address",
                    controller: PersonalInfoController().addressController,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          bgColor: kScaffoldColor,
                          label: "Zip Code",
                          controller: PersonalInfoController().zipCodeConroller,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfigs.screenWidth! * 0.02,
                      ),
                      Expanded(
                        child: InputField(
                          bgColor: kScaffoldColor,
                          label: "City",
                          controller: PersonalInfoController().cityConroller,
                        ),
                      ),
                    ],
                  ),
                  InputField(
                    bgColor: kScaffoldColor,
                    label: "Phone Number",
                    controller: PersonalInfoController().phoneNumberController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
