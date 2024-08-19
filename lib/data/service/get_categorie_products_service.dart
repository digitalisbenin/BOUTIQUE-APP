import 'dart:convert';
import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> fetchProduitsByCategorie(String categorieSlug) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(Uri.parse('$categorieProductUrl/$categorieSlug'), headers: {
      'Accept': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        final jsonData = json.decode(response.body);
        if (jsonData['articles'] is List<dynamic>) {
          List<dynamic> articles = jsonData['articles'];
          List<Produits> produitsList = articles.map((article) => Produits.fromJson(article)).toList();
          apiResponse.data = produitsList;
        } else {
          apiResponse.error = 'Invalid response format';
        }
        break;
      case 401:
        apiResponse.error = 'Unauthorized';
        break;
      default:
        apiResponse.error = 'Something went wrong';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Server error: $e';
  }

  return apiResponse;
}
