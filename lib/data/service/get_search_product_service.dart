import 'dart:convert';
import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Produits>> fetchProducts() async {
    final response = await http.get(Uri.parse(articlesUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Produits.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
