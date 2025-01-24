import 'dart:convert';

import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_user_orders_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_commande.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/user_orders/track_order/widget/single_order_track.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  List<Commande> commandeList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    retrieveCommandes();
  }

  Future<void> retrieveCommandes() async {
    ApiResponse response = await getUserOrders();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['commande'] as List<dynamic>;
      commandeList = myData.map<Commande>((json) => Commande.fromJson(json)).toList();
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: const LargeText(largeTitle: "Mes Commandes"),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.trash, color: kPrimaryColor,)),
        ],
      ),
      body: loading 
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
            onRefresh: retrieveCommandes,
            child: ListView.builder(
                itemCount: commandeList.length,
                itemBuilder: (context, index) {
                  return SingleUserOrderTrack(commande: commandeList[index]);
                },
              ),
          ),
    );
  }
}


/* 
import 'dart:convert';

import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_user_orders_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_commande.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/user_orders/track_order/track_order.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {

  List<Commande> commandeList = [];
   bool loading = true;

  @override
  void initState() {
    super.initState();
    retrieveCommandes();
  }

  Future<void> retrieveCommandes() async {
    ApiResponse response = await getUserOrders();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['commande'] as List<dynamic>;
      commandeList = myData.map<Commande>((json) => Commande.fromJson(json)).toList();
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: const LargeText(largeTitle: "Mes Commandes"),
        actions: [
         /*  AppTextButton(
            btnTitle: "Supprimer",
            onPressed: () {},
          ) */
         IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.trash, color: kPrimaryColor,))
        ],
      ),
      body: ListView(
        children: const [
          SingleOrderTrack(),
          SingleOrderTrack(),
          SingleOrderTrack(),
          SingleOrderTrack(),
          SingleOrderTrack(),
          SingleOrderTrack(),
          SingleOrderTrack(),
          SingleOrderTrack(),
        ],
      ),
    );
  }
}
 */