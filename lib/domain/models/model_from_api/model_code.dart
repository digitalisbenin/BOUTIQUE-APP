class Code {
  int? id;
  int? userId;
  String? codeParents;
  String? codeUser;
  int? bonus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Code({
    this.id,
    this.userId,
    this.codeParents,
    this.codeUser,
    this.bonus,
    this.createdAt,
    this.updatedAt,
  });

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      id: json['code']['id'],
      userId: json['code']['user_id'],
      codeParents: json['code']['codeParents'],
      codeUser: json['code']['codeUser'],
      bonus: json['code']['bonus'],
      createdAt: DateTime.parse(json['code']['created_at']),
      updatedAt: DateTime.parse(json['code']['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "codeParents": codeParents,
        "codeUser": codeUser,
        "bonus": bonus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
