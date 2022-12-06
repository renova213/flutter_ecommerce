import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/apps_repository.dart';
import '../models/login_model.dart';

class LoginViewModel extends ChangeNotifier {
  final AppsRepository appsRepository = AppsRepository();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  bool get obscureText => _obscureText;

  Future<void> postLogin() async {
    await appsRepository.postLogin(
      LoginModel(
          email: _emailController.text, password: _passwordController.text),
    );

    emailController.clear();
    passwordController.clear();
    _obscureText = true;
    notifyListeners();
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    notifyListeners();
  }

  void changeVisibleText(bool obscureText) {
    _obscureText = obscureText;
    notifyListeners();
  }
}
