import 'dart:convert';

import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/product_model.dart';
import '../../utils/constants/app_colors/app_colors.dart';

class AppProvider with ChangeNotifier {
///// Favourte Produt And Dis Favourte
  final FavoritesManager _favoritesManager = FavoritesManager();

  final List<Produits> _favoriteProducts = [];

  List<Produits> get favoriteProducts => _favoriteProducts;

  void addFavorite(Produits product) {
    _favoriteProducts.add(product);
    _favoritesManager.saveFavoriteProducts(_favoriteProducts);

    notifyListeners();
  }

  void removeFavorite(Produits product) {
    _favoriteProducts.remove(product);
    _favoritesManager.saveFavoriteProducts(_favoriteProducts);
    notifyListeners();
  }

  void toggleFavourite(String productId) {
    final productIndex =
        productList.indexWhere((p) => p.productID == productId);
    if (productIndex >= 0) {
      productList[productIndex].isFavourte =
          !productList[productIndex].isFavourte;
    }
    _favoritesManager.saveFavoriteProducts(_favoriteProducts);

    notifyListeners();
  }

  bool _isClicked = false;

  void showSnackBar(
      {required BuildContext context, required String snackBarTtile}) {
    if (!_isClicked) {
      _isClicked = true;
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content: Center(
                child: MediumText(
                  middleTitle: snackBarTtile,
                  color: kWhiteColor,
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          )
          .closed
          .then((value) {
        _isClicked = false;
      });
    }
  }
}

class FavoritesManager {
  static const String _kFavoritesKey = 'favorites';

  Future<List<dynamic>> getFavoriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteListJson = prefs.getString(_kFavoritesKey);
    if (favoriteListJson != null) {
      final favoriteList = jsonDecode(favoriteListJson) as List<dynamic>;
      return favoriteList
          .map((item) => Produits.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<void> saveFavoriteProducts(List<Produits> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteListJson =
        jsonEncode(favorites.map((item) => item.toJson()).toList());
    await prefs.setString(_kFavoritesKey, favoriteListJson);
  }
}
