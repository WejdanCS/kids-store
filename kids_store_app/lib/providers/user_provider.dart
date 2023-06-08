import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _token;

  void addToken(String token) {
    _token = token;
    notifyListeners();
  }

  String? get token => _token;
}
