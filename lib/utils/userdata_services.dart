import 'package:flutter/material.dart';

class UserData {
  String name = "";
  String email = "";
  String phone = "";
}

class UserDataProvider with ChangeNotifier {
  UserData _userData = UserData();

  UserData get userData => _userData;

  void setUserData({required String name, required String email, required String phone}) {
    _userData.name = name;
    _userData.email = email;
    _userData.phone = phone;
    notifyListeners();
  }
}
