class BonusModel {
    int id;
    int userId;
    String codeParents;
    String codeUser;
    int bonus;
    DateTime createdAt;
    DateTime updatedAt;

    BonusModel({
        required this.id,
        required this.userId,
        required this.codeParents,
        required this.codeUser,
        required this.bonus,
        required this.createdAt,
        required this.updatedAt,
    });

    factory BonusModel.fromJson(Map<String, dynamic> json) => BonusModel(
        id: json["id"],
        userId: json["user_id"],
        codeParents: json["codeParents"],
        codeUser: json["codeUser"],
        bonus: json["bonus"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "codeParents": codeParents,
        "codeUser": codeUser,
        "bonus": bonus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}