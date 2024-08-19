import 'dart:convert';

import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> addProductToFavorite(articleId) async {
  ApiResponse apiResponse = ApiResponse();
  print(articleId);
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse('$addProductToFavoriteUrl?article_id=$articleId'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
    }
  } catch (e) {
    print("caatch error ::: $e");
    apiResponse.error = serverError;
  }
  return apiResponse;
}
