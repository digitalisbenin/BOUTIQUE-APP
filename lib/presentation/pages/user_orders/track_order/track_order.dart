import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_order_details_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_user_orders_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_commande.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_detail_commande.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/bottom_page/bottom_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/small_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/static_data/icons_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TrackOrder extends StatefulWidget {
  final String commandeId;
  final String commandeNum;
  final String commandeDate;
  final String commandeTotalPrice;

  final String livreurId;
  final String status;
  const TrackOrder(
      {super.key,
      required this.commandeId,
      required this.commandeNum,
      required this.commandeDate,
      required this.commandeTotalPrice,
      required this.livreurId,
      required this.status});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  List<DetailCommande> detailCommandeList = [];
  List<Commande> commandeList = [];
  bool loading = true;

  bool enCours = false;
  bool livre = true;

  @override
  void initState() {
    super.initState();
    _getOrderDetails();
  }

  Future<void> _getOrderDetails() async {
    ApiResponse response = await getOrderDetail(widget.commandeId);
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['detailCommande'] as List<dynamic>;
      detailCommandeList = myData
          .map<DetailCommande>((json) => DetailCommande.fromJson(json))
          .toList();
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

  Future<void> retrieveCommandes() async {
    ApiResponse response = await getUserOrders();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['commande'] as List<dynamic>;
      commandeList =
          myData.map<Commande>((json) => Commande.fromJson(json)).toList();
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
        title: const LargeText(
          largeTitle: "Suivi de commande",
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              AppRoutes.pushAndRemoveUntil(context, const BottomBarPage());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: RefreshIndicator(
        onRefresh: retrieveCommandes,
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                // AppRoutes.pushToNextPage(context, const TrackOrder());
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  leading: CircleAvatar(
                    backgroundColor: kPrimaryColor.withOpacity(0.1),
                    radius: 30,
                    child: SvgPicture.asset(
                      myOrders,
                      color: kPrimaryColor,
                      height: 30,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeText(
                        largeTitle: "Commande ${widget.commandeNum}",
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.003,
                      ),
                      SmallText(
                        smallText: "Date: ${widget.commandeDate}",
                        color: kLightBlackColor,
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.003,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    // mainAxisAlignment: MainAxisAlignment.,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallText(
                        smallText:
                            "total Price: ${widget.commandeTotalPrice} FCFA",
                        color: kLightBlackColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  (widget.status == 'En Attente')
                      ? ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          leading: CircleAvatar(
                            backgroundColor: kPrimaryColor.withOpacity(0.1),
                            radius: 30,
                            child: SvgPicture.asset(
                              orderPlaced,
                              color: kPrimaryColor,
                            ),
                          ),
                          title: const MediumText(
                            middleTitle: "Commande placée",
                          ),
                          subtitle: SmallText(
                            smallText: "Placée le: ${widget.commandeDate}",
                            color: kLightBlackColor,
                          ),
                        )
                      : const SizedBox(),
                  (widget.status == 'En cours')
                      ? ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          leading: CircleAvatar(
                            backgroundColor: kPrimaryColor.withOpacity(0.1),
                            radius: 30,
                            child: SvgPicture.asset(
                              orderConfirmed,
                              color: kPrimaryColor,
                            ),
                          ),
                          title: const MediumText(
                            middleTitle: "Commande confirmée",
                          ),
                          subtitle: SmallText(
                            smallText: "Confirmée le: ${widget.commandeDate}",
                            color: kLightBlackColor,
                          ),
                        )
                      : (widget.status == 'En Attente')
                          ? const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox(),
                  (widget.status == 'En cours')
                      ? ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          leading: CircleAvatar(
                            backgroundColor: kPrimaryColor.withOpacity(0.1),
                            radius: 30,
                            child: SvgPicture.asset(
                              orderShipped,
                              color: kPrimaryColor,
                            ),
                          ),
                          title: const MediumText(
                            middleTitle: "Commande affectée",
                          ),
                          subtitle: SmallText(
                            smallText: "Affectée le: ${widget.commandeDate}",
                            color: kLightBlackColor,
                          ),
                        )
                      : (widget.status == 'En Attente')
                          ? const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox(),
                  (widget.status == 'En cours')
                      ? ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          leading: CircleAvatar(
                            backgroundColor: kPrimaryColor.withOpacity(0.1),
                            radius: 30,
                            child: SvgPicture.asset(
                              outDelivery,
                              color: kPrimaryColor,
                            ),
                          ),
                          title: const MediumText(
                            middleTitle: "En cours de livraison",
                          ),
                          subtitle: SmallText(
                            smallText: "En cours le: ${widget.commandeDate}",
                            color: kLightBlackColor,
                          ),
                        )
                      : (widget.status == 'En Attente')
                          ? const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox(),
                  (widget.status == 'Livré')
                      ? ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          leading: CircleAvatar(
                            backgroundColor: kPrimaryColor.withOpacity(0.1),
                            radius: 30,
                            child: SvgPicture.asset(
                              orderDelivered,
                              color: kPrimaryColor,
                            ),
                          ),
                          title: const MediumText(
                            middleTitle: "Commande livrée",
                          ),
                          subtitle: SmallText(
                            smallText: "Livrée le: ${widget.commandeDate}",
                            color: kLightBlackColor,
                          ),
                        )
                      : (widget.status == 'En cours')
                          ? const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox(),
                  (widget.status == 'Non Livré')
                      ? ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          leading: CircleAvatar(
                            backgroundColor: Colors.red.withOpacity(0.1),
                            radius: 30,
                            child: const Icon(CupertinoIcons.clear, size: 14, color: Colors.red,),
                          ),
                          title: const MediumText(
                            middleTitle: "Commande non livrée",
                          ),
                          subtitle: SmallText(
                            smallText: "Date: ${widget.commandeDate}",
                            color: kLightBlackColor,
                          ),
                        )
                      : (widget.status == 'En Attente')
                          ? const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: SizedBox(),
                            ) : (widget.status == 'En cours') ? const SizedBox()
                          : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
