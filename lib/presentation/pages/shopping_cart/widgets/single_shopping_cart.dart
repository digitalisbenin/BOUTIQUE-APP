// ignore_for_file: use_build_context_synchronously

import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/update_article_quantity_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_shopping.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/dialog_box/app_dialog_box.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class SingleShoppingCartWidget extends StatefulWidget {
  final ShoppingCartModel shoppingCartProduct;
  final VoidCallback onQuantityUpdated;
  const SingleShoppingCartWidget({
    super.key,
    required this.shoppingCartProduct,
    required this.onQuantityUpdated,
  });

  @override
  State<SingleShoppingCartWidget> createState() =>
      _SingleShoppingCartWidgetState();
}

class _SingleShoppingCartWidgetState extends State<SingleShoppingCartWidget> {
  int quantity = 1;

  List<ShoppingCartModel> articlesList = [];
  bool isLoading = true;
  String errorMessage = '';

  void _showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: kBlackColor.withOpacity(0.6),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AppDialLogBox(
            shoppingCartProduct: widget.shoppingCartProduct,
            dialBoxTitle: "Confirmer la suppression",
            dialBoxContext:
                "Êtes-vous sûr de vouloir supprimer ce produit de votre panier?",
          ),
        );
      },
    );
  }

  Future<void> _updateArticleQuantity(int newQuantity) async {
    ApiResponse response = await updateArticleQuantity(
      widget.shoppingCartProduct.articleId,
      newQuantity,
    );
    if (response.error != null) {
      setState(() {
        widget.shoppingCartProduct.updateQuantite(newQuantity);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Quantité modifiée")));
        widget.onQuantityUpdated();
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${response.error}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    double price = double.parse(widget.shoppingCartProduct.montant.toString());
    double totalPrice = price * widget.shoppingCartProduct.quantite;

    return Container(
      height: 140,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kPrimaryColor.withOpacity(0.1),
                image: DecorationImage(
                  image: NetworkImage(
                      widget.shoppingCartProduct.productModel.imageUrl.toString()),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.shoppingCartProduct.productModel.nomArticle
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.titleLarge(context),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showMyDialog(context);
                        },
                        icon: Icon(
                          Icons.delete_rounded,
                          color: kLightBlackColor,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "${totalPrice.toStringAsFixed(0)} FCFA",
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.titleLarge(context)!.copyWith(
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: kLightBlackColor.withOpacity(0.05),
                          ),
                          splashRadius: 20,
                          onPressed: () {
                            if (widget.shoppingCartProduct.quantite > 1) {
                              _updateArticleQuantity(
                                  widget.shoppingCartProduct.quantite - 1);
                            }
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth! * 0.04,
                        ),
                        Text(
                          widget.shoppingCartProduct.quantite.toString(),
                          style: AppStyle.titleMedium(context)!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth! * 0.04,
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: kPrimaryColor.withOpacity(0.1),
                          ),
                          splashRadius: 24,
                          onPressed: () {
                            _updateArticleQuantity(
                                widget.shoppingCartProduct.quantite + 1);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
