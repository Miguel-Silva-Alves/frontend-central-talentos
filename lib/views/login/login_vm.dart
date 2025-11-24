import 'package:frontend_central_talentos/models/user.dart';
import 'package:frontend_central_talentos/services/login_service.dart';
import 'package:frontend_central_talentos/views/login/login_model.dart';
import 'package:flutter/material.dart';

class LoginVm extends ValueNotifier<LoginModel> {
  LoginVm() : super(LoginModel());

  LoginService loginService = LoginService();

  Future<void> login() async {
    if (value.email.isNotEmpty && value.password.isNotEmpty) {
      debugPrint(
          'Logging in with email: ${value.email} and password: ${value.password}');
      value.loadingLogin = true;
      notifyListeners();

      // Call service of login
      User? user = await loginService.login(value.email, value.password);
      value.userLoggedIn = user;

      // Perform login logic here
      debugPrint('Login successful');
      value.loginSuccess = user == null ? false : true;
      value.loginError = user == null ? 'Email or password incorrect' : null;
    } else {
      value.loginError = 'Email or password incorrect';
    }

    value.loadingLogin = false;
    notifyListeners();
  }
}
