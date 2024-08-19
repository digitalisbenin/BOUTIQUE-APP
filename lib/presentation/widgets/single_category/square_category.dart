import 'package:digitalis_shop_grocery_app/api_constant.dart';
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_category.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/view_all_page/view_product/view_all_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class SquareCategory extends StatelessWidget {
  final Categorie categoryModel;
  const SquareCategory({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return GestureDetector(
      onTap: () {
        print('Slug: ${categoryModel.slug}');
        AppRoutes.pushToNextPage(
          context,
          ViewAllPage(
            categoryTitle: categoryModel.nomCategorie ?? '',
            categorySlug: categoryModel.slug ?? '',
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: SizeConfigs.screenHeight! * 0.1,
              child: Image.network(
                categoryModel.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            MediumText(
              middleTitle: categoryModel.nomCategorie.toString().length > 10
                  ? '${categoryModel.nomCategorie.toString().substring(0, 10)}...'
                  : categoryModel.nomCategorie.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
