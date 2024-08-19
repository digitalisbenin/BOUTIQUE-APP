class User {
  int? id;
  int? roleId;
  String? nom;
  String? prenoms;
  String? email;
  String? phoneNumber;
  String? adresseResidence;
  String? codeParents;
  int? points;
  String? emailVerifiedAt;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.roleId,
    this.nom,
    this.prenoms,
    this.email,
    this.phoneNumber,
    this.adresseResidence,
    this.codeParents,
    this.points,
    this.emailVerifiedAt,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    roleId: json["role_id"],
    nom: json["nom"],
    prenoms: json["prenoms"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    adresseResidence: json["adresseResidence"],
    codeParents: json["codeParents"],
    points: json["points"],
    emailVerifiedAt: json["email_verified_at"],
    token: json["token"],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role_id": roleId,
    "nom": nom,
    "prenoms": prenoms,
    "email": email,
    "phoneNumber": phoneNumber,
    "adresseResidence": adresseResidence,
    "codeParents" : codeParents,
    "points": points,
    "email_verified_at": emailVerifiedAt,
    'token': token,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
