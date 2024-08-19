import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';

class DetailCommande {
  final int id;
  final int articleId;
  final int commandeId;
  final int? userId;
  final int quantite;
  final double montantLigneCommande;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Produits article;

  DetailCommande({
    required this.id,
    required this.articleId,
    required this.commandeId,
    this.userId,
    required this.quantite,
    required this.montantLigneCommande,
    required this.createdAt,
    required this.updatedAt,
    required this.article,
  });

  factory DetailCommande.fromJson(Map<String, dynamic> json) {
    return DetailCommande(
      id: json['id'],
      articleId: json['article_id'],
      commandeId: json['commande_id'],
      userId: json['user_id'],
      quantite: json['quantite'],
      montantLigneCommande: json['montantLigneCommande'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      article: Produits.fromJson(json['article']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'article_id': articleId,
      'commande_id': commandeId,
      'user_id': userId,
      'quantite': quantite,
      'montantLigneCommande': montantLigneCommande,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'article': article.toJson(),
    };
  }
}