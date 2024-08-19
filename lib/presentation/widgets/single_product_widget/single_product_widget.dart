import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/add_product_to_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_all_user_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/remove_product_from_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/presentation/provider/app_provider.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/decoration/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductWidget extends StatefulWidget {
  final Produits productModel;
  const SingleProductWidget({super.key, required this.productModel});

  @override
  State<SingleProductWidget> createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  bool _isFavorite = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _addProductToFavorite() async {
    print("id du produit : ${widget.productModel.id}");
    ApiResponse apiResponse =
        await addProductToFavorite(widget.productModel.id);
    print('Add to favorite response message: ${apiResponse.error}');
    if (apiResponse.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Ajouté aux favoris !")));
      if (mounted) {
        setState(() {
          _isFavorite = true;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${apiResponse.error}")));
    }
  }

  void _removeProductFromFavorite() async {
    print("id du produit : ${widget.productModel.id}");
    ApiResponse apiResponse =
        await removeProductFromFavorite(widget.productModel.id);
    print('Remove favorite response error: ${apiResponse.error}');
    if (apiResponse.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Supprimé des favoris !")));
      if (mounted) {
        setState(() {
          _isFavorite = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${apiResponse.error}")));
    }
  }

  Future<void> _checkIfFavorite() async {
    ApiResponse response = await getAllUsersFavoriteProduct();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['favoris'] as List<dynamic>;
      List<Produits> favoriteProducts =
          myData.map<Produits>((json) => Produits.fromJson(json)).toList();
      if (mounted) {
        setState(() {
          _isFavorite = favoriteProducts.any((article) => article.id == widget.productModel.id);
        });
      }
    } else {
      if (mounted) {
        setState(() {
          errorMessage = response.error!;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 140,
      decoration: DecorationConstants.myDecoration,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.productModel.imageUrl ?? '',
                    ),
                  ),
                ),
                child: IconButton(
                  splashRadius: 24,
                  style: IconButton.styleFrom(
                    backgroundColor: kPrimaryColor.withOpacity(0.2),
                  ),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                    if (_isFavorite) {
                      _addProductToFavorite();
                    } else {
                      _removeProductFromFavorite();
                    }
                  },
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.productModel.nomArticle ?? '',
                    style: AppStyle.titleMedium(context)!.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MediumText(
                        middleTitle:
                            "${widget.productModel.prixVenteArticle} FCFA",
                        fontWeight: FontWeight.bold,
                      ),
                    ],
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
