import 'dart:convert';
import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_category.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/domain/models/category_model.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> fetchCategoriesWithProducts(String categorieSlug) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(Uri.parse('$categorieProductUrl/$categorieSlug'), headers: {
      'Accept': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        final jsonData = json.decode(response.body);
        List<dynamic> categoriesData = jsonData['categories'];
        List<Categorie> categoriesList = categoriesData.map((categoryData) => Categorie.fromJson(categoryData)).toList();
        apiResponse.data = categoriesList;
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
