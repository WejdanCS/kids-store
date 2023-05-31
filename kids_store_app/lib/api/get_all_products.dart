import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kids_store_app/models/allproducts_model.dart';
import 'package:kids_store_app/utlis/constants.dart';

Future<ProductsResponse>? getAllProducts() async {
  try {
    http.Response response = await http.get(
      Uri.parse("${Constants.apiUrl}/products"),
      headers: {"Content-Type": "application/json"},
    );
    ProductsResponse productsResponse =
        ProductsResponse.fromJson(jsonDecode(response.body));
    return productsResponse;
  } catch (err) {
    rethrow;
  }
}
