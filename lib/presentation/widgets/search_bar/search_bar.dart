import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_articles_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/product_view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  late Future<List<Produits>> _articlesFuture;
  List<Produits> articlesList = [];

  CustomSearchDelegate() {
    _articlesFuture = retrieveArticles();
    _articlesFuture.then((articles) {
      articlesList = articles;
    });
  }

  Future<List<Produits>> retrieveArticles() async {
    ApiResponse response = await getArticles();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['article'] as List<dynamic>;
      return myData.map<Produits>((json) => Produits.fromJson(json)).toList();
    } else {
      throw Exception(response.error);
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(
              context); // Afficher tous les articles lorsque la recherche est effacée
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Produits> productMatchingQuery = [];
    for (var product in articlesList) {
      if (product.nomArticle!.toLowerCase().contains(query.toLowerCase())) {
        productMatchingQuery.add(product);
      }
    }

    if (productMatchingQuery.isEmpty) {
      return Center(
        child: Text('Cet article n\'est pas disponible'),
      );
    }

    return ListView.builder(
      itemCount: productMatchingQuery.length,
      itemBuilder: (context, index) {
        final product = productMatchingQuery[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                '$baseUrl$assetUrlArticles${product.imagePath ?? ''}'),
          ),
          title: LargeText(largeTitle: product.nomArticle!),
          subtitle: MediumText(
              middleTitle: '${product.prixVenteArticle.toString()} FCFA'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductView(
                  productView: product,
                  categoryId: product.categorieId.toString(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Produits> productMatchingQuery = [];
    // Afficher tous les articles si la requête est vide
    if (query.isEmpty) {
      productMatchingQuery.addAll(articlesList);
    } else {
      // Filtrer les articles par la requête
      for (var product in articlesList) {
        if (product.nomArticle!.toLowerCase().contains(query.toLowerCase())) {
          productMatchingQuery.add(product);
        }
      }
    }

    if (query.isEmpty) {
      productMatchingQuery =
          articlesList; // Afficher tous les articles si la recherche est vide
    }

    return ListView.builder(
      itemCount: productMatchingQuery.length,
      itemBuilder: (context, index) {
        final product = productMatchingQuery[index];
        return ListTile(
          onTap: () {
            AppRoutes.pushToNextPage(
              context,
              ProductView(
                productView: product,
                categoryId: product.categorieId.toString(),
              ),
            );
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
                '$baseUrl$assetUrlArticles${product.imagePath ?? ''}'),
          ),
          title: LargeText(largeTitle: product.nomArticle!),
          subtitle: MediumText(
              middleTitle: '${product.prixVenteArticle.toString()} FCFA'),
        );
      },
    );
  }
}
