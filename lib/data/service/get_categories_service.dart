import 'dart:convert';

import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getCategories() async {
  ApiResponse apiResponse = ApiResponse();
  
  try {
    final response = await http.get(Uri.parse(categoriesUrl), headers: {
      'Accept': 'application/json',
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);

        apiResponse.data;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}