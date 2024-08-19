import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/add_product_to_cart_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/add_product_to_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_products_by_categorie_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/remove_product_from_favorite_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_favoris.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/favourte_page/single_favorite_product_widget.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/product_view/product_view.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/view_all_product_page/view_all_product.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/single_product_widget/single_product_widget.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/decoration/gradient_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../config/helpers/input_controller/input_controller.dart';
import '../../../config/router/app_route.dart';
import '../../../config/theme/app_style/app_style.dart';
import '../../../responsive/size_config.dart';
import '../../../utils/constants/app_colors/app_colors.dart';
import '../../provider/app_provider.dart';
import '../../provider/shopping_cart_provider.dart';
import '../../widgets/app_btn/app_text_button.dart';
import '../../widgets/app_btn/primary_button.dart';
import '../shopping_cart/shopping_cart.dart';

class FavoriteProductView extends StatefulWidget {
  final FavoriteModel favoriteProductView;
  final String categoryId;
  const FavoriteProductView(
      {super.key, required this.favoriteProductView, required this.categoryId});

  @override
  State<FavoriteProductView> createState() => _FavoriteProductViewState();
}

class _FavoriteProductViewState extends State<FavoriteProductView> {
  int quatity = 1;
  bool _isExpanded = false;
  bool _loading = true;

  List<FavoriteModel> favoritesArticlesList = []; // Liste pour stocker les articles
  List<Produits> articlesList = []; // Liste pour stocker les articles

  @override
  void initState() {
    super.initState();
    retrieveArticlesByCategorie();
  }

  bool _isFavorite = false;

  void _addProductToFavorite() async {
    print("id du produit : ${widget.favoriteProductView.article.id}");
    ApiResponse apiResponse = await addProductToFavorite(widget.favoriteProductView.article.id);
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
    print("id du produit : ${widget.favoriteProductView.article.id}");
    ApiResponse apiResponse =
        await removeProductFromFavorite(widget.favoriteProductView.article.id);
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

  void _addProductToCart() async {
    ApiResponse apiResponse = await addProductToCart(
        widget.favoriteProductView.article.id, quatity, widget.favoriteProductView.article.prixVenteArticle);
    if (apiResponse.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Produit ajouté au panier")));
      setState(() {
        _isFavorite = false;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${apiResponse.error}")));
    }
  }

  Future<void> retrieveArticlesByCategorie() async {
    ApiResponse response =
        await getArticlesByCategorie(widget.favoriteProductView.article.categorieId.toString());
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['article'] as List<dynamic>;
      articlesList =
          myData.map<Produits>((json) => Produits.fromJson(json)).toList();
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double price = double.parse(widget.favoriteProductView.article.prixVenteArticle.toString());

    double totalPrice = price * quatity;

    SizeConfigs().init(context);
    /* AppProvider appProvider = Provider.of<AppProvider>(context); */
    /* ShoppingCartProvider shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context); */
    /* final isFavorite =
        appProvider.favoriteProducts.contains(widget.productView); */
    const smallText = "Lorem Ipsum is simply dummy text of the printing and "
        "typesetting industry. Lorem Ipsum has been the industry's standard "
        "dummy text ever since the 1500s, when an unknown printer took a "
        "galley of type and scrambled it to make a type specimen book.Lorem Ipsum is simply dummy text of the printing and "
        "typesetting industry. Lorem Ipsum has been the industry's standard "
        "dummy text ever since the 1500s,";
    final truncatedText = _isExpanded ? smallText : smallText.substring(0, 245);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: LargeText(
          largeTitle: widget.favoriteProductView.article.nomArticle.toString(),
        ),
       /*  actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              if (_isFavorite) {
                _addProductToFavorite();
                /* appProvider.showSnackBar(
                        context: context,
                        snackBarTtile: "This item is saved your Favorite list",
                      ); */
              } else {
                _removeProductFromFavorite();
                /* appProvider.showSnackBar(
                        context: context,
                        snackBarTtile:
                            "This item is Removed From your Favorite list",
                      ); */
              }
            },
            /* onPressed: () {
              if (isFavorite) {
                appProvider.removeFavorite(widget.productView);
              } else {
                appProvider.addFavorite(widget.productView);
              }
              if (!isFavorite) {
                appProvider.showSnackBar(
                  context: context,
                  snackBarTtile: "This item is saved your Favorite list",
                );
              } else {
                appProvider.showSnackBar(
                  context: context,
                  snackBarTtile: "This item is Removed From your Favorite list",
                );
              }
            }, */
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: kPrimaryColor,
            ),
          ),
        ], */
      ),
      body: Container(
        decoration: BoxDecoration(gradient: linearGradient),
        child: ListView(
          controller: AppControllers().productViewListViewController,
          children: [
            Container(
              height: SizeConfigs.screenHeight! * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      widget.favoriteProductView.article.imageUrl ?? ''),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfigs.screenHeight! * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LargeText(
                    largeTitle: widget.favoriteProductView.article.nomArticle.toString(),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: SizeConfigs.screenHeight! * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "⭐ ⭐ ⭐ ⭐ ⭐",
                        style: AppStyle.titleLarge(context)!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          MediumText(
                            middleTitle:
                                'stock: ${widget.favoriteProductView.article.stock.toString()}',
                            color: kLightBlackColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          LargeText(
                            largeTitle: '${totalPrice.toStringAsFixed(0)} FCFA',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfigs.screenHeight! * 0.02,
                  ),
                  Text(
                    truncatedText,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: kLightBlackColor,
                          fontFamily: "PoppinsLight",
                        ),
                  ),
                  if (!_isExpanded)
                    RichText(
                      text: TextSpan(
                        text: 'Voir plus',
                        style: AppStyle.titleMedium(context)!.copyWith(
                          color: kLightBlackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              _isExpanded = true;
                            });
                          },
                      ),
                    ),
                  if (_isExpanded)
                    RichText(
                      text: TextSpan(
                        text: 'Voir moins',
                        style: AppStyle.titleMedium(context)!.copyWith(
                          color: kLightBlackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              _isExpanded = false;
                            });
                          },
                      ),
                    ),
                  SizedBox(
                    height: SizeConfigs.screenHeight! * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    kLightBlackColor.withOpacity(0.05),
                              ),
                              splashRadius: 20,
                              onPressed: () {
                                if (quatity > 1) {
                                  setState(() {
                                    quatity--;
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            SizedBox(
                              width: SizeConfigs.screenWidth! * 0.04,
                            ),
                            Text(
                              quatity.toString(),
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
                                setState(() {
                                  quatity++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: SizeConfigs.screenWidth! / 2,
                        height: SizeConfigs.screenHeight! * 0.08,
                        child: PrimaryButton(
                          buttonTitle: "Ajouter au panier",
                          onPressed: () {
                            _addProductToCart();
                            /* shoppingCartProvider.addProductToCart(
                              widget.productView,
                              quatity,
                              totalPrice,
                            ); */
                            AppRoutes.pushToNextPage(
                              context,
                              const ShoppingCart(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfigs.screenHeight! * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Produit Similaire",
                        style: AppStyle.titleMedium(context),
                      ),
                      AppTextButton(
                        btnTitle: "Tout voir",
                        onPressed: () {
                          print(
                              "widget.categoryId ::: ${widget.categoryId.toString()}");
                          AppRoutes.pushToNextPage(
                            context,
                            ViewAllProductsPage(
                              categoryId: widget.categoryId.toString(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfigs.screenHeight! * 0.01,
                  ),
                  if (articlesList.isNotEmpty)
                    SingleChildScrollView(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        children: articlesList.take(4).map((produit) {
                          return GestureDetector(
                            onTap: () {
                              print('Category ID: ${produit.categorieId}');
                              AppRoutes.pushToNextPage(
                                context,
                                ProductView(
                                    productView: produit,
                                    categoryId: produit.categorieId.toString()),
                              );
                            },
                            child: SingleProductWidget(productModel: produit),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
