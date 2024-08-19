import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_category.dart';

class Produits {
  int? id;
  int? categorieId;
  String? nomArticle;
  String? codeArticle;
  String? imagePath;
  String? imageUrl;
  String? description;
  String? status;
  int? prixAchatArticle;
  int? prixVenteArticle;
  int? stock;
  DateTime? createdAt;
  DateTime? updatedAt;
  Categorie? categorie;

  Produits(
      {this.id,
      this.categorieId,
      this.nomArticle,
      this.codeArticle,
      this.imagePath,
      this.imageUrl,
      this.description,
      this.status,
      this.prixAchatArticle,
      this.prixVenteArticle,
      this.stock,
      this.createdAt,
      this.updatedAt,
      this.categorie});

  factory Produits.fromJson(Map<String, dynamic> json) => Produits(
        id: json["id"],
        categorieId: json["categorie_id"],
        nomArticle: json["nomArticle"],
        codeArticle: json["codeArticle"],
        imagePath: json["image_path"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        status: json["status"],
        prixAchatArticle: json["prixAchatArticle"],
        prixVenteArticle: json["prixVenteArticle"],
        stock: json["stock"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        categorie: json["categorie"] != null
            ? Categorie.fromJson(json["categorie"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categorie_id": categorieId,
        "nomArticle": nomArticle,
        "codeArticle": codeArticle,
        "image_path": imagePath,
        "imageUrl": imageUrl,
        "description": description,
        "status": status,
        "prixAchatArticle": prixAchatArticle,
        "prixVenteArticle": prixVenteArticle,
        "stock": stock,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "categorie": categorie?.toJson(),
      };
}
