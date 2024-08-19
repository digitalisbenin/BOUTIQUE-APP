class CategoryModel {
  String categoryTitle;
  String categoryImage;
  CategoryModel({
    required this.categoryImage,
    required this.categoryTitle,
  });
}

List<CategoryModel> categoryList = [
  CategoryModel(
    categoryImage:
        "https://www.transparentpng.com/thumb/vegetable/fZslFj-vegetable-cabbage-transparent.png",
    categoryTitle: "Légumes",
  ),
  CategoryModel(
    categoryImage:
        "https://atlas-content-cdn.pixelsquid.com/stock-images/strawberry-a8nAGrF-600.jpg",
    categoryTitle: "Fruits",
  ),
  CategoryModel(
    categoryImage:
        "https://www.pngitem.com/pimgs/m/380-3803337_image-cocktails-png-transparent-png.png",
    categoryTitle: "Breuvages",
  ),
  CategoryModel(
    categoryImage:
        "https://www.pngplay.com/wp-content/uploads/7/Grocery-Items-PNG-HD-Quality.png",
    categoryTitle: "Épicerie",
  ),
  CategoryModel(
    categoryImage:
        "https://purepng.com/public/uploads/large/purepng.com-sunflower-oilsunflower-oilcooking-oilfrying-oilnon-volatile-oil-1411529833012ojmrn.png",
    categoryTitle: "Huile comestible",
  ),
  CategoryModel(
    categoryImage:
        "https://www.zoro.com/static/cms/product/full/Z0yCIxfo5oy.JPG",
    categoryTitle: "Ménage",
  ),
  CategoryModel(
    categoryImage:
        "https://www.85cbakerycafe.com/wp-content/uploads/2022/03/Bread-Image.png",
    categoryTitle: "Boulangerie",
  ),
  CategoryModel(
    categoryImage:
        "https://www.foodland.at/sub/foodland.sk/shop/product/instantne-polievky-hovadzie-prichut-omachi-80-g-2375.jpg",
    categoryTitle: "Nourriture instantanée",
  ),
  CategoryModel(
    categoryImage:
        "https://www.kindpng.com/picc/m/160-1606870_personal-care-products-png-transparent-png.png",
    categoryTitle: "Soins personnels",
  ),
];
