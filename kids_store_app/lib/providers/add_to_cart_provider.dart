import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kids_store_app/models/allproducts_model.dart';
import 'package:kids_store_app/models/product_cart_model.dart';

class CartModel extends ChangeNotifier {
  final List<ProductCart> _items = [];
  double _totalPrice = 0;

  void add(ProductCart product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(ProductCart product) {
    _items.remove(product);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  List<ProductCart> getProducts() {
    return _items;
    // notifyListeners();
  }

  void addQty(int index, int qty) {
    _items[index].quantity = _items[index].quantity! + qty;
    notifyListeners();
  }

  void deleteQty(int index, int qty) {
    _items[index].quantity = _items[index].quantity! - qty;
    notifyListeners();
  }

  double getTotal() {
    _totalPrice = 0;
    _items.forEach((element) {
      _totalPrice += element.quantity! * element.product!.price!;
    });
    return _totalPrice;
  }
}
