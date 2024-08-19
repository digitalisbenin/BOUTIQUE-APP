import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_categories_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_category.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/single_category/square_category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Categorie> categoryList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    retrieveCategories();
  }

  Future<void> retrieveCategories() async {
    setState(() {
      _loading = true;
    });
    ApiResponse response = await getCategories();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['categorie'] as List<dynamic>;
      categoryList = myData.map<Categorie>((json) => Categorie.fromJson(json)).toList();
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
        backgroundColor: kWhiteColor,
        title: const LargeText(
          largeTitle: "Catégories",
        ),
      ),
      body: _loading ? const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            for (Categorie productData in categoryList)
              SquareCategory(
                categoryModel: productData,
              ),
          ],
        ),
      ),
    );
  }
}
