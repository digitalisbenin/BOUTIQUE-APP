import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/post_order_service.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/bottom_page/bottom_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/primary_button.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessfully extends StatefulWidget {
  final int? amount;
  final String transactionId;
  final String userAdresse;
  final String userPhone;
  String? userBonus;

  OrderSuccessfully(
      {super.key,
      this.amount,
      required this.transactionId,
      required this.userAdresse,
      required this.userPhone, this.userBonus});

  @override
  State<OrderSuccessfully> createState() => _OrderSuccessfullyState();
}

class _OrderSuccessfullyState extends State<OrderSuccessfully> {
  @override
  void initState() {
    super.initState();
    /*  Future.delayed(const Duration(seconds: 15), () {
      _postOrder();
      AppRoutes.pushAndRemoveUntil(
        context,
        const BottomBarPage(),
      );
    }); */
  }

  Future<void> _postOrder() async {
    ApiResponse response = await postOrder(
        widget.transactionId, widget.userAdresse, widget.userPhone, widget.userBonus);
    print("id transaction ::: ${widget.transactionId}");
    if (response.error == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Status : ${response.error}'),
        ));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Lottie.asset('assets/lottie/done_order.json'),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Commande éffectuée pour : ${widget.amount} FCFA",
                    textAlign: TextAlign.center,
                    style: AppStyle.bodySmall(context)!.copyWith(
                      color: kBlackColor,
                      fontSize: 23,
                    ),
                  ), /* LargeText(
                    largeTitle:
                        "Commande éffectuée pour : ${widget.amount} FCFA",
                  ) */
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const LargeText(
                  largeTitle: "Votre commande avec succès",
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Merci d'avoir passé votre commande ! Notre équipe prépare désormais vos produits d'épicerie avec le plus grand soin. Ils seront emballés et vous seront livrés sous peu.",
                  textAlign: TextAlign.center,
                  style: AppStyle.bodySmall(context)!.copyWith(
                    color: kLightBlackColor,
                    fontSize: 14,
                  ),
                ),
                PrimaryButton(
                  buttonTitle: "Revenir à l'accueil",
                  onPressed: () {
                    _postOrder();
                    AppRoutes.pushAndRemoveUntil(
                      context,
                      const BottomBarPage(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
