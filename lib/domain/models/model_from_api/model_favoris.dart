import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';

class FavoriteModel {
  final int id;
  final int articleId;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Produits article;

  FavoriteModel({
    required this.id,
    required this.articleId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.article,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      articleId: json['article_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      article: Produits.fromJson(json['article']),
    );
  }
}
