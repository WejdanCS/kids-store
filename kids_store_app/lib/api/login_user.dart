import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kids_store_app/models/login_model.dart';
import 'package:kids_store_app/utlis/constants.dart';

Future<LoginRespone>? login({required email, required password}) async {
  try {
    // print("data email:${email} password: ${password}");
    // print("API URL:${Constants.apiUrl}/login");
    http.Response response = await http.post(
        Uri.parse("${Constants.apiUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    LoginRespone loginRespone =
        LoginRespone.fromJson(jsonDecode(response.body));
    // print("response:${loginRespone.message}");
    return loginRespone;
  } catch (err) {
    rethrow;
  }
}
