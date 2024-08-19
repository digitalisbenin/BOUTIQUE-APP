class Categorie {
    int? id;
    String? imagePath;
    String? nomCategorie;
    String? slug;
    String? description;
    String? status;
    String? imageUrl;
    DateTime? createdAt;
    DateTime? updatedAt;

    Categorie({
        this.id,
        this.imagePath,
        this.nomCategorie,
        this.slug,
        this.description,
        this.status,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
    });

    factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
        id: json["id"],
        imagePath: json["image_path"],
        nomCategorie: json["nomCategorie"],
        slug: json["slug"],
        description: json["description"],
        status: json["status"],
        imageUrl: json["imageUrl"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_path": imagePath,
        "nomCategorie": nomCategorie,
        "slug": slug,
        "description": description,
        "status": status,
        "imageUrl": imageUrl,
        "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    };
}