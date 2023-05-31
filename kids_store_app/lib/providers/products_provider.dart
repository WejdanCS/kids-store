import 'package:flutter/material.dart';
import 'package:kids_store_app/models/allproducts_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<Products> _items = [];

  // void add(Product product) {
  //   _items.add(product);
  //   notifyListeners();
  // }

  void addProducts(List<Products> product) {
    _items = product;
    // notifyListeners();
  }

  // void removeProduct(Product product) {
  //   _items.remove(product);
  //   notifyListeners();
  // }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  List<Products> getProducts() {
    // _items.clear();
    return _items;
    // notifyListeners();
  }
}
