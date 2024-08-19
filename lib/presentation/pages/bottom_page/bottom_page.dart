
import 'package:digitalis_shop_grocery_app/presentation/pages/favourte_page/favourte_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/home_page/home_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/profile_page/profile_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/shopping_cart/shopping_cart.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/static_data/icons_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/app_colors/app_colors.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const FavoritesPage(),
    const ShoppingCart(),
    const ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kWhiteColor,
          elevation: 0,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(homeBottom, color: kGrey),
              activeIcon: SvgPicture.asset(homeBottom, color: kPrimaryColor),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(faveBottom, color: kGrey, height: 22),
              activeIcon: SvgPicture.asset(
                faveBottom,
                color: kPrimaryColor,
                height: 22,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(cartBottom, color: kGrey),
              activeIcon: SvgPicture.asset(cartBottom, color: kPrimaryColor),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                userBottom,
                color: kGrey,
                height: 26,
              ),
              activeIcon: SvgPicture.asset(
                userBottom,
                color: kPrimaryColor,
                height: 26,
              ),
              label: '',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (int intValue) {
            setState(() {
              currentIndex = intValue;
            });
          },
          selectedIconTheme: const IconThemeData(
            color: kPrimaryColor, // Set the active color for all icons
          ),
        ),
      ),
      body: IndexedStack(
        children: [
          _widgetOptions.elementAt(currentIndex),
        ],
      ),
    );
  }
}
