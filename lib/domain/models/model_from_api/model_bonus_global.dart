import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_bonus.dart';

class Bonus {
  bool? success;
  String? message;
  BonusModel? bonus;

  Bonus({
    this.success,
    this.message,
    this.bonus,
  });

  factory Bonus.fromJson(Map<String, dynamic> json) => Bonus(
        success: json["success"],
        message: json["message"],
        bonus: BonusModel.fromJson(json["bonus"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "bonus": bonus!.toJson(),
      };
}
