import 'dart:convert';

import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/auth/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> updateProfile(nom, prenom, email, phoneNumber,
    currentPassword, newPassword, confirmNewPassword) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.put(Uri.parse(updateProfilUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'nom': nom,
          'prenoms': prenom,
          'email': email,
          'phoneNumber': phoneNumber,
          'current_password': currentPassword,
          'password': newPassword,
          'password_confirmation': confirmNewPassword
        }));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('update error ::: ${e}');
    apiResponse.error = serverError;
  }
  return apiResponse;
}
