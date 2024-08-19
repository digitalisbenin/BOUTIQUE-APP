import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/add_product_to_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_all_user_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/remove_product_from_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_favoris.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/decoration/app_decoration.dart';
import 'package:flutter/material.dart';

class SingleFavoriteProductWidget extends StatefulWidget {
  final FavoriteModel favoriteModel;
  const SingleFavoriteProductWidget({super.key, required this.favoriteModel});

  @override
  State<SingleFavoriteProductWidget> createState() => _SingleFavoriteProductWidgetState();
}

class _SingleFavoriteProductWidgetState extends State<SingleFavoriteProductWidget> {
  bool _isFavorite = false;
  String errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfFavorite();
  }

  void _addProductToFavorite() async {
    print("id du produit : ${widget.favoriteModel.article.id}");
    ApiResponse apiResponse =
        await addProductToFavorite(widget.favoriteModel.article.id);
    print('Add to favorite response message: ${apiResponse.error}');
    if (apiResponse.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Ajouté aux favoris !")));
      setState(() {
        _isFavorite = true;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${apiResponse.error}")));
    }
  }

  void _removeProductFromFavorite() async {
    print("id du produit : ${widget.favoriteModel.article.id}");
    ApiResponse apiResponse =
        await removeProductFromFavorite(widget.favoriteModel.article.id);
    print('Remove favorite response error: ${apiResponse.error}');
    if (apiResponse.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Supprimé des favoris !")));
      setState(() {
        _isFavorite = false;
      });
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
      List<FavoriteModel> favoriteProducts =
          myData.map<FavoriteModel>((json) => FavoriteModel.fromJson(json)).toList();
      setState(() {
        _isFavorite = favoriteProducts.any((article) => article.id == widget.favoriteModel.id);
      });
    } else {
      setState(() {
          errorMessage = response.error!;
        });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
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
                      widget.favoriteModel.article.imageUrl ?? '',
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
                    widget.favoriteModel.article.nomArticle ?? '',
                    style: AppStyle.titleMedium(context)!.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /* Text(
                        "${productModel.prixAchatArticle} FCFA",
                        style: AppStyle.titleMedium(context)!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: kLightBlackColor,
                        ),
                      ), */
                      MediumText(
                        middleTitle:
                            "${widget.favoriteModel.article.prixVenteArticle} FCFA",
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
