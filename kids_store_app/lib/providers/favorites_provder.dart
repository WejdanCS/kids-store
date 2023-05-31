import 'package:flutter/material.dart';
import 'package:kids_store_app/models/allproducts_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _items = [];
  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  List<Product> getProducts() {
    return _items;
    // notifyListeners();
  }
}
