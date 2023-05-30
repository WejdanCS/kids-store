import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kids_store_app/models/register_model.dart';
import 'package:kids_store_app/utlis/constants.dart';

Future<RegisterResponse>? register(
    {required email,
    required password,
    required passwordConfirmation,
    required name,
    required address}) async {
  try {
    // print("data email:${email} password: ${password}");
    // print("API URL:${Constants.apiUrl}/login");
    dynamic userData = {
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "name": name,
      "address": address
    };
    print("User data:${userData}");
    http.Response response = await http.post(
        Uri.parse("${Constants.apiUrl}/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData));
    RegisterResponse registerRespone =
        RegisterResponse.fromJson(jsonDecode(response.body));
    print("response:${registerRespone.message}");
    return registerRespone;
  } catch (err) {
    rethrow;
  }
}
