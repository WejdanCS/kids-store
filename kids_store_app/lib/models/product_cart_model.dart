import 'package:kids_store_app/models/allproducts_model.dart';

class ProductCart {
  Product? product;
  int? quantity;

  ProductCart({required this.product, required this.quantity});

  ProductCart.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product'] = product;
    data['quantity'] = quantity;
    return data;
  }
}
