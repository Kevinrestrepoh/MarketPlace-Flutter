import 'package:app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  User? user;

  UserProvider({this.user});

  void setUser({required User? user})async{
    this.user = user;
    notifyListeners();
  }
}