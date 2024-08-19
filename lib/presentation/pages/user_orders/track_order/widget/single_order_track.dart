import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_commande.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/user_orders/track_order/track_order.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/small_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/static_data/icons_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleUserOrderTrack extends StatelessWidget {
  final Commande commande;

  const SingleUserOrderTrack({super.key, required this.commande});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         AppRoutes.pushToNextPage(context, TrackOrder(
          commandeId: commande.id.toString(),
          commandeNum: commande.numeroCommande,
          commandeDate: commande.createdAt.toLocal().toString().split(' ')[0],
          commandeTotalPrice: commande.montantTotal.toString(),
          livreurId: commande.livreurId.toString(),
          status: commande.status,
         ));
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
                largeTitle: "Commande ${commande.numeroCommande}",
              ),
              SizedBox(
                height: SizeConfigs.screenHeight! * 0.003,
              ),
              SmallText(
                smallText: "Date: ${commande.createdAt.toLocal().toString().split(' ')[0]}",  // Formater la date selon vos besoins
                color: kLightBlackColor,
              ),
              SizedBox(
                height: SizeConfigs.screenHeight! * 0.003,
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                smallText: "Total: ${commande.montantTotal} FCFA",
                color: kLightBlackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
