
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../search_bar/search_bar.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: SizeConfigs.screenHeight! * 0.07,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kScaffoldColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          readOnly: true,
          onTap: () =>
              showSearch(context: context, delegate: CustomSearchDelegate()),
          decoration: InputDecoration(
            icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                height: 30,
              ),
            ),
            border: InputBorder.none,
            hintText: "Mots clés...",
          ),
        ),
      ),
    );
  }
}
