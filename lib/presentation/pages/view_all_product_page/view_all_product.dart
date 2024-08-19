import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_products_by_categorie_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/product_view/product_view.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:flutter/material.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_categorie_products_service.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/single_product_widget/single_product_widget.dart';

class ViewAllProductsPage extends StatefulWidget {
  final String categoryId;

  const ViewAllProductsPage({Key? key, required this.categoryId,}) : super(key: key);

  @override
  _ViewAllProductsPageState createState() => _ViewAllProductsPageState();
}

class _ViewAllProductsPageState extends State<ViewAllProductsPage> {
  bool _loading = true;

  List<Produits> articlesList = []; // Liste pour stocker les articles

  @override
  void initState() {
    super.initState();
    retrieveArticlesByCategorie();
  }

  Future<void> retrieveArticlesByCategorie() async {
    ApiResponse response =
        await getArticlesByCategorie(widget.categoryId.toString());
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['article'] as List<dynamic>;
      articlesList =
          myData.map<Produits>((json) => Produits.fromJson(json)).toList();
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LargeText(
          largeTitle: "Produits Similaire",
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: [
                  for (Produits produit in articlesList)
                    GestureDetector(
                      onTap: () {
                        print("slug categorie article${produit.categorie?.slug}");
                        AppRoutes.pushToNextPage(
                          context,
                          ProductView(productView: produit, categoryId: produit.categorieId.toString(),),
                        );
                      },
                      child: SingleProductWidget(productModel: produit),
                    ),
                ],
              ),
            ),
    );
  }
}
