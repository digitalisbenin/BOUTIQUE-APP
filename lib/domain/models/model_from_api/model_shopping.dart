import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';

class ShoppingCartModel {
  final int id;
  final int articleId;
  final int userId;
  int quantite;
  final double montant;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Produits productModel;

  ShoppingCartModel({
    required this.id,
    required this.articleId,
    required this.userId,
    required this.quantite,
    required this.montant,
    required this.createdAt,
    required this.updatedAt,
    required this.productModel,
  });

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    return ShoppingCartModel(
      id: json['id'],
      articleId: json['article_id'],
      userId: json['user_id'],
      quantite: json['quantite'],
      montant: json['montant'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      productModel: Produits.fromJson(json['article']),
    );
  }

  void updateQuantite(int newQuantite) {
    quantite = newQuantite;
  }
}
