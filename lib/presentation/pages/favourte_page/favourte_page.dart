import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/config/theme/app_style/app_style.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_all_user_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_favoris.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/favourte_page/favorite_product_view.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/favourte_page/single_favorite_product_widget.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final FavoriteModel? productModel;

  const FavoritesPage({super.key, this.productModel});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<FavoriteModel> favoriteArticlesList = [];
  bool isLoading = true;
  String errorMessage = '';

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteProducts();
    _checkIfFavorite();
  }

  Future<void> _fetchFavoriteProducts() async {
    setState(() {
      isLoading = true;
    });
    ApiResponse response = await getAllUsersFavoriteProduct();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['favoris'] as List<dynamic>;
      favoriteArticlesList = myData
          .map<FavoriteModel>((json) => FavoriteModel.fromJson(json))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  Future<void> _checkIfFavorite() async {
  if (widget.productModel == null) {
    setState(() {
      isFavorite = false;
    });
    return;
  }

  ApiResponse response = await getAllUsersFavoriteProduct();
  if (response.error == null) {
    Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
    List<dynamic> myData = jsonResponse['favoris'] as List<dynamic>;
    List<Produits> favoriteProducts =
        myData.map<Produits>((json) => Produits.fromJson(json)).toList();
    setState(() {
      isFavorite = favoriteProducts
          .any((article) => article.id == widget.productModel!.id);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: const LargeText(
          largeTitle: "Mes Favoris",
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : favoriteArticlesList.isEmpty
              ? Center(
                  child: Text(
                    "Aucun favori ajouté pour l'instant!",
                    style: AppStyle.titleMedium(context),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: favoriteArticlesList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final favoriteProduct = favoriteArticlesList[index];
                          return GestureDetector(
                            onTap: () {
                              final categoryId =
                                  favoriteProduct.article.categorieId ??
                                      'Id not available';
                              print('ID: $categoryId');
                              AppRoutes.pushToNextPage(
                                context,
                                FavoriteProductView(
                                  favoriteProductView: favoriteProduct,
                                  categoryId: categoryId.toString(),
                                ),
                              );
                            },
                            child: SingleFavoriteProductWidget(
                              favoriteModel: favoriteProduct,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
