/* import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_produit.dart';
import 'package:digitalis_shop_grocery_app/domain/models/model_from_api/model_shopping.dart';
import 'package:flutter/foundation.dart';

class ShoppingCartProvider extends ChangeNotifier {
  final List<ShoppingCartModel> _items = [];

  List<ShoppingCartModel> get items => _items;

  void addProductToCart(
      Produits product, int productQty, double productPrice) {
    ShoppingCartModel? existingItem;

    for (ShoppingCartModel item in _items) {
      if (item.productModel.id.toString() == product.id.toString()) {
        existingItem = item;
        break;
      }
    }

    if (existingItem != null) {
      // Update the values to the new value
      existingItem.quantity = productQty;
      existingItem.prductPrice = productPrice;
    } else {
      _items.add(
        ShoppingCartModel(
            id: product.id!.toInt(),
            productModel: product,
            quantite: productQty,
            montant: productPrice),
      );
    }

    notifyListeners();
  }

  void updateQuantity(ShoppingCartModel cartItem, int newQuantity) {
  // Find the item in _items list
  int index = _items.indexWhere(
    (item) => item.productModel.id == cartItem.productModel.id,
  );

  if (index != -1) {
    // Update quantity of the existing item
    _items[index].quantity = newQuantity;
    // Notify listeners that the data has changed
    notifyListeners();
  }
}


  void removeProductFromCart(ShoppingCartModel item) {
    _items.remove(item);
    notifyListeners();
  }

  double get subTotalCost {
  double subTotal = 0.0;
  for (ShoppingCartModel item in _items) {
    double price = double.parse(item.productModel.prixVenteArticle.toString());
    subTotal += price * item.quantite;
  }
  return subTotal;
}


  /* double get subTotalCost {
    double subTotal = 0.0;
    for (ShoppingCartModel item in _items) {
      double price =
          double.parse(item.productModel.prixVenteArticle.toString());

      subTotal += price * item.quantity;
    }

    return subTotal;
  } */
}
 */