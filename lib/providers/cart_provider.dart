import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItemModel> _cart = {};

  int get itemCount => _cart.length;
  Map<int, CartItemModel> get items => _cart;

  int get quantityCount {
    int total = 0;
    _cart.forEach((_, item) {
      total += item.quantity;
    });
    return total;
  }

  double get total {
    double sum = 0.0;
    _cart.forEach((_, item) => sum += item.quantity * item.price);
    return sum;
  }

  void addItem(ProductModel product) {
    _cart.update(
      product.id,
      (item) => CartItemModel.from(item, newQuantity: item.quantity + 1),
      ifAbsent: () => CartItemModel.fromProduct(product),
    );
    notifyListeners();
  }

  void removeItem(int key) {
    _cart.remove(key);
    notifyListeners();
  }
}
