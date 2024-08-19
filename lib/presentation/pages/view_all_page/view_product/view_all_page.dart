import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/product_view/product_view.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:flutter/material.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_categorie_products_service.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/single_product_widget/single_product_widget.dart';

class ViewAllPage extends StatefulWidget {
  final String categorySlug;
  final String categoryTitle;

  const ViewAllPage(
      {Key? key, required this.categorySlug, required this.categoryTitle})
      : super(key: key);

  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  List<Produits> produitsList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchProduits();
  }

  Future<void> fetchProduits() async {
    setState(() {
      _loading = true;
    });

    final response = await fetchProduitsByCategorie(widget.categorySlug);

    setState(() {
      _loading = false;
    });

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    } else if (response.data is List<Produits>) {
      setState(() {
        produitsList = response.data as List<Produits>;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid response format'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LargeText(
          largeTitle: widget.categoryTitle,
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
                  for (Produits produit in produitsList)
                    GestureDetector(
                      onTap: () {
                        print(
                            "slug categorie article${produit.categorie?.slug}");
                        AppRoutes.pushToNextPage(
                          context,
                          ProductView(
                            productView: produit,
                            categoryId: produit.categorieId.toString(),
                          ),
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
