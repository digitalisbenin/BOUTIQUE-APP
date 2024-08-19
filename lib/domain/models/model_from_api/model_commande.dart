class Commande {
  final int id;
  final int userId;
  final int? livreurId;
  final String numeroCommande;
  final double montantTotal;
  final String status;
  final String adresseLivraison;
  final String livraisonPhoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  Commande({
    required this.id,
    required this.userId,
    this.livreurId,
    required this.numeroCommande,
    required this.montantTotal,
    required this.status,
    required this.adresseLivraison,
    required this.livraisonPhoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'],
      userId: json['user_id'],
      livreurId: json['livreur_id'],
      numeroCommande: json['numeroCommande'],
      montantTotal: json['montantTotal'].toDouble(),
      status: json['status'],
      adresseLivraison: json['adresseLivraison'],
      livraisonPhoneNumber: json['livraisonPhoneNumber'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'livreur_id': livreurId,
      'numeroCommande': numeroCommande,
      'montantTotal': montantTotal,
      'status': status,
      'adresseLivraison': adresseLivraison,
      'livraisonPhoneNumber': livraisonPhoneNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
