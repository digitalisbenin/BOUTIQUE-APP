import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_category.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart'; // Assurez-vous que le chemin est correct

class SingleCategory extends StatelessWidget {
  final Categorie categoryModel;
  const SingleCategory({
    super.key,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: kWhiteColor,
            radius: 25,
            backgroundImage: NetworkImage(categoryModel.imageUrl ?? ''),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            categoryModel.nomCategorie.toString().length > 10
                ? '${categoryModel.nomCategorie.toString().substring(0, 10)}...'
                : categoryModel.nomCategorie.toString(),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
