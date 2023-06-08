import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kids_store_app/models/allcategories_model.dart';
import 'package:kids_store_app/utlis/constants.dart';

Future<CategoriesResponse>? getAllCategories({required String token}) async {
  try {
    http.Response response =
        await http.get(Uri.parse("${Constants.apiUrl}/categories"), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    CategoriesResponse categoriesResponse =
        CategoriesResponse.fromJson(jsonDecode(response.body));

    return categoriesResponse;
  } catch (err) {
    rethrow;
  }
}
