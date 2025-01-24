import 'dart:async';  // Ajoutez cette importation pour utiliser Timer
import 'package:digitalis_shop_grocery_app/presentation/pages/category_page/category_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalis_shop_grocery_app/config/router/app_route.dart';
import 'package:digitalis_shop_grocery_app/data/service/apiResponseModel.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_articles_service.dart';
import 'package:digitalis_shop_grocery_app/data/service/get_categories_service.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_category.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/product_view/product_view.dart';
import 'package:digitalis_shop_grocery_app/presentation/pages/view_all_page/view_product/view_all_page.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/input_field/search_input.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/single_category/single_category.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/single_product_widget/single_product_widget.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/large_text.dart';
import 'package:digitalis_shop_grocery_app/presentation/widgets/text_widget/middle_text.dart';
import 'package:digitalis_shop_grocery_app/responsive/size_config.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/app_colors/app_colors.dart';
import 'package:digitalis_shop_grocery_app/utils/constants/decoration/gradient_color.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Categorie> categoryList = [];
  List<Produits> articlesList = []; // Liste pour stocker les articles
  late Future<ApiResponse> categoriesFuture;
  bool loading = true;
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    retrieveCategories();
    retrieveArticles();
    categoriesFuture = getCategories();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _inactivityTimer?.cancel();
    super.dispose();
  }

  Future<void> retrieveCategories() async {
    setState(() {
      loading = true;
    });
    ApiResponse response = await getCategories();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['categorie'] as List<dynamic>;
      categoryList =
          myData.map<Categorie>((json) => Categorie.fromJson(json)).toList();
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  Future<void> retrieveArticles() async {
    setState(() {
      loading = true;
    });
    ApiResponse response = await getArticles();
    if (response.error == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> myData = jsonResponse['article'] as List<dynamic>;
      articlesList =
          myData.map<Produits>((json) => Produits.fromJson(json)).toList();
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _handleScroll() {
    _inactivityTimer?.cancel();
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isFabVisible) {
        setState(() {
          _isFabVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isFabVisible) {
        setState(() {
          _isFabVisible = true;
        });
      }
    }
    _inactivityTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _isFabVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
        ),
        child: SafeArea(
          child: ListView(
            controller: _scrollController,
            children: [
              Column(
                children: [
                  const SearchInputField(),
                  CarouselSlider(
                    items: [
                      // Image.network(
                      //     "https://srikakulamads.com/wp-content/uploads/2020/12/What-is-online-grocery-shopping.png"),
                      Image.asset('assets/images/grocery-2.jpg'),
                      Image.asset(
                          'assets/images/What-is-online-grocery-shopping.jpg'),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      height: SizeConfigs.screenHeight! * 0.2,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfigs.screenHeight! * 0.02,
              ),
              ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: const LargeText(
                  largeTitle: "Catégories",
                  fontWeight: FontWeight.bold,
                ),
                trailing: TextButton(
                  onPressed: () {
                    AppRoutes.pushToNextPage(
                      context,
                      const CategoryPage(),
                    );
                  },
                  child: const MediumText(
                    middleTitle: "Tout voir",
                    fontFamily: "PoppinsSemiBold",
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfigs.screenHeight! * 0.01,
              ),
             loading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryList
                      .map(
                        (categorie) => GestureDetector(
                          onTap: () {
                            print('Slug: ${categorie.slug}');
                            AppRoutes.pushToNextPage(
                              context,
                              ViewAllPage(
                                categoryTitle: categorie.nomCategorie ?? '',
                                categorySlug: categorie.slug ?? '',
                              ),
                            );
                          },
                          child: SingleCategory(
                            categoryModel: categorie,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: SizeConfigs.screenHeight! * 0.01,
              ),
              const ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                title: LargeText(
                  largeTitle: "Nos Produits",
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Affichage des articles sous forme de grille
              if (articlesList.isNotEmpty)
              loading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    children: articlesList
                        .map(
                          (produit) => GestureDetector(
                            onTap: () {
                              print('id categorie: ${produit.categorieId}');
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
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedScale(
        scale: _isFabVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: const Icon(Icons.arrow_upward, color: Colors.white,),
        ),
      ),
    );
  }
}
