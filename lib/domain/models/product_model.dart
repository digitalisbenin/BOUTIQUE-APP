class ProductModel {
  String productImage;
  String productTitle;
  String productOldPrice;
  String productNewPrice;
  String productID;
  bool isFavourte;
  ProductModel({
    required this.productImage,
    required this.productNewPrice,
    required this.productOldPrice,
    required this.productTitle,
    required this.productID,
    this.isFavourte = false,
  });
  bool contains(String query) {
    // Perform the logic to check if the product contains the query
    return productTitle.toLowerCase().contains(query.toLowerCase());
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productImage: json['productImage'],
      productTitle: json['productTitle'],
      productOldPrice: json['productOldPrice'],
      productNewPrice: json['productNewPrice'],
      productID: json['productID'],
      isFavourte: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productImage': productImage,
      'productTitle': productTitle,
      'productOldPrice': productOldPrice,
      'productNewPrice': productNewPrice,
      'productID': productID,
      'isFavorite': isFavourte,
    };
  }
}

List<ProductModel> productList = [
  ProductModel(
    productID: '1',
    productImage:
        "https://i.pinimg.com/originals/1e/aa/d9/1eaad9822383e95f901f896ed7b351f3.png",
    productNewPrice: "501",
    productOldPrice: "40",
    productTitle: "Gâteau Au Chocolats Rouges",
  ),
  ProductModel(
    productID: '2',
    productImage:
        "https://png.pngtree.com/png-vector/20230212/ourmid/pngtree-delicious-breakfast-png-image_6594817.png",
    productNewPrice: "600",
    productOldPrice: "30",
    productTitle: "Chips de pommes de terre",
  ),
  ProductModel(
    productID: '3',
    productImage:
        "https://cdn.shopify.com/s/files/1/2528/8566/products/NewWebsiteCircleCrop_37d656c9-10ec-45bf-a030-ee82dcf010af_1600x.png?v=1680718320",
    productNewPrice: "900",
    productOldPrice: "52",
    productTitle: "Sandwichs pour le petit-déjeuner",
  ),
  ProductModel(
    productID: '4',
    productImage:
        "https://penyet.express/wp-content/uploads/2023/03/ayam-bakar.png",
    productNewPrice: "1200",
    productOldPrice: "90",
    productTitle: "Boissons énergisantes",
  ),
  ProductModel(
    productID: '5',
    productImage:
        "https://i.pinimg.com/originals/1e/aa/d9/1eaad9822383e95f901f896ed7b351f3.png",
    productNewPrice: "600",
    productOldPrice: "20",
    productTitle: "Vinaigrette ranch",
  ),
  ProductModel(
    productID: '6',
    productImage:
        "https://www.pngmart.com/files/15/Breakfast-Food-Plate-Top-View-PNG.png",
    productNewPrice: "900",
    productOldPrice: "40",
    productTitle: "Vinaigrette ranch",
  ),
];
