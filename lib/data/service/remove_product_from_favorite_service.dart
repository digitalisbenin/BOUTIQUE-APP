import 'dart:convert';

import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> removeProductFromFavorite(articleId) async {
  ApiResponse apiResponse = ApiResponse();
  print(articleId);
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse('$removeProductFromFavoriteUrl?article_id=$articleId'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        print('apiResponse.data ::: ${apiResponse.data}');
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print("remove favorite error : $e");
    apiResponse.error = serverError;
  }
  return apiResponse;
}
