import 'dart:convert';

import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_code.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// login
Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(loginUrl),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    print("statut du body : ${response.body}");
    print("statut de la réponse : ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          apiResponse.data = User.fromJson(jsonResponse);
          apiResponse.error = jsonResponse['message'];
        } else {
          apiResponse.error = "Invalid response format";
        }
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
    print("error ::::::::::: $e");
    apiResponse.error = serverError;
  }

  return apiResponse;
}

// register
Future<ApiResponse> register(String nom, String prenom, String codeParent,
    String email, String password, String confirmPass) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(registerUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      'name': nom,
      'prenoms': prenom,
      'codeParents': codeParent,
      'email': email,
      'password': password,
      'password_confirmation': confirmPass,
    });
    print('response du body ::: ${response.body}');
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
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

// User
Future<ApiResponse> getUser() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(userUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var jsonData = jsonDecode(response.body);
        apiResponse.data = User.fromJson(jsonData);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('get user errors ::::: ${e}');
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// get inscription
Future<ApiResponse> getInscriptionInfo() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(getInscriptionInfoUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var jsonData = jsonDecode(response.body);
        apiResponse.data = Code.fromJson(jsonData);
        break;
      case 201:
        var jsonData = jsonDecode(response.body);
        apiResponse.data = Code.fromJson(jsonData);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('get user code errors ::::: ${e}');
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// get user token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString("token") ?? '';
}

//get uerId
Future<int> getUserid() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userid') ?? 0;
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove("token");
}
