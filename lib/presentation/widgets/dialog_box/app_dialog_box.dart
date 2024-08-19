import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/delete_product_from_cart_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_all_users_cart_product_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_shopping.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/app_btn/app_text_button.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppDialLogBox extends StatefulWidget {
  final String dialBoxTitle;
  final String dialBoxContext;
  final ShoppingCartModel shoppingCartProduct;

  const AppDialLogBox({
    super.key,
    required this.dialBoxContext,
    required this.dialBoxTitle,
    required this.shoppingCartProduct,
  });

  @override
  State<AppDialLogBox> createState() => _AppDialLogBoxState();
}

class _AppDialLogBoxState extends State<AppDialLogBox> {
  List<ShoppingCartModel> articlesList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    _fetchCartProducts();
    super.initState();
  }

  Future<void> _fetchCartProducts() async {
    setState(() {
      isLoading = true;
    });
    ApiResponse response = await getAllUsersCartProducts();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['panier'] as List<dynamic>;
      articlesList = myData
          .map<ShoppingCartModel>((json) => ShoppingCartModel.fromJson(json))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = response.error!;
      });
    }
  }

  Future<void> _deleteProductFromCart() async {
    ApiResponse response =
        await deleteProductFromCart(widget.shoppingCartProduct.articleId);
    if (response.error != null) {
      _fetchCartProducts();
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "${widget.shoppingCartProduct.productModel.nomArticle} a été supprimé du panier")));
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${response.error}")));
      print("ERREUR DE L'API : ${response.error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.dialBoxTitle,
        style: AppStyle.headlineSmall(context),
      ),
      content: Text(
        widget.dialBoxContext,
        textAlign: TextAlign.center,
        style: AppStyle.titleMedium(context)!.copyWith(color: kLightBlackColor),
      ),
      actions: [
        AppTextButton(
          btnTitle: "Annuler",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        AppTextButton(
          btnTitle: "Oui",
          onPressed: () {
            _deleteProductFromCart();
            print(
                "product : ${widget.shoppingCartProduct.productModel.nomArticle}");
            Navigator.of(context).pop();
            
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 3),
            content: Text(
                "${widget.shoppingCartProduct.productModel.nomArticle} a été supprimé du panier. Réactualiser la page pour constater la suppression du produit.")));
          },
        ),
      ],
    );
  }
}
