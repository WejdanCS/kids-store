import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kids_store_app/models/login_model.dart';
import 'package:kids_store_app/models/post_order_model.dart';
import 'package:kids_store_app/models/product_cart_model.dart';
import 'package:kids_store_app/utlis/constants.dart';

Future<PostOrederResponse>? postOrder(
    {required List<ProductCart> products, required String token}) async {
  try {
    // print(products.length);
    var ord1 = products
        .map((ele) => {"product_id": ele.product!.id, "quantity": ele.quantity})
        .toList();
    // print("ord1:${ord1}");
    dynamic order = jsonEncode({"products": ord1});
    // print("order:${order}");
    http.Response response =
        await http.post(Uri.parse("${Constants.apiUrl}/orders/create"),
            headers: {
              "Content-Type": "application/json",
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: order);
    // print("reponse :${response.body}");
    PostOrederResponse orederResponse =
        PostOrederResponse.fromJson(jsonDecode(response.body));
    print("response:${orederResponse.message}");
    return orederResponse;
  } catch (err) {
    rethrow;
  }
}
