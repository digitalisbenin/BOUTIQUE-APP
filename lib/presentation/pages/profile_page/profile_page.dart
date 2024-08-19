import 'dart:io';

import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/user_model.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/about_me/about_me_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/singin_page/singin_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/authentication_page/welcome_page/welcome_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/favourte_page/favourte_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/user_orders/user_order.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/static_data/icons_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 200;
  final double profileHeight = 144;

  @override
  void initState() {
    super.initState();
    getUserProfileInfo();
  }

  User? user;
  bool _loading = true;

  Future<void> getUserProfileInfo() async {
    ApiResponse response = await getUser();

    setState(() {
      _loading = false;
    });

    if (response.error == null) {
      setState(() {
        user = response.data as User;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const WelcomePage()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : user == null
                ? const Center(
                    child: Text(
                        "Erreur lors du chargement des informations de l'utilisateur"))
                : ListView(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      _buildTop(),
                      buildContent(),
                    ],
                  ));
  }

  buildContent() {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LargeText(
              largeTitle: "${user!.prenoms} ${user!.nom}",
              fontFamily: "PoppinsMedium",
            ),
            SizedBox(
              height: SizeConfigs.screenHeight! * 0.004,
            ),
            MediumText(
              middleTitle: "${user!.email}",
              fontFamily: "PoppinsLight",
            ),
          ],
        ),
        SizedBox(
          height: SizeConfigs.screenHeight! * 0.03,
        ),
        _buildSingleContent(
          onPress: () {
            AppRoutes.pushToNextPage(
              context,
              const AboutMe(),
            );
          },
          leadingIconData: aboutme,
          titleData: "A mon propos",
        ),
        _buildSingleContent(
          onPress: () {
            AppRoutes.pushToNextPage(
              context,
              const UserOrder(),
            );
          },
          leadingIconData: myOrders,
          titleData: "Mes Commandes",
        ),
        _buildSingleContent(
          onPress: () {
            AppRoutes.pushToNextPage(
              context,
              const FavoritesPage(),
            );
          },
          leadingIconData: myFavorite,
          titleData: "Mes Favoris",
        ),
        ListTile(
          onTap: () {
            logout().then((value) => {
                  AppRoutes.pushAndRemoveUntil(
                    context,
                    const LoginPage(),
                  )
                });
          },
          leading: SvgPicture.asset(
            signOut,
            color: kPrimaryColor,
          ),
          title: const MediumText(
            middleTitle: "Se déconnecter",
            // fontFamily: "PoppinsMedium",
          ),
        ),
      ],
    );
  }

  _buildTop() {
    final double bottomPadding = profileHeight / 2;
    final double top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: _buildBackgroudImage(),
        ),
        Positioned(
          top: top,
          child: _buildProfileImage(),
        )
      ],
    );
  }

  _buildBackgroudImage() => Container(
        color: kWhiteColor,
        height: coverHeight,
        width: double.infinity,
      );
  _buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2.3,
        backgroundColor: kPrimaryColor,
        child: Center(
          child: GestureDetector(
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
            child: CircleAvatar(
              radius: profileHeight / 2.5,
              backgroundColor: Colors.green,
              backgroundImage: _image == null
                  ? const NetworkImage(
                      "https://concepto.de/wp-content/uploads/2018/09/Red-e1537290436781-800x400.jpg",
                    )
                  : FileImage(_image!) as ImageProvider,
            ),
          ),
        ),
      );

  _buildSingleContent(
      {required String leadingIconData,
      required String titleData,
      required Function()? onPress}) {
    return ListTile(
      onTap: onPress,
      leading: SvgPicture.asset(
        leadingIconData,
        color: kPrimaryColor,
      ),
      title: MediumText(
        middleTitle: titleData,
        // fontFamily: "PoppinsMedium",
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
