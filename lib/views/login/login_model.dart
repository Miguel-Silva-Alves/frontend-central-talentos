import 'package:frontend_central_talentos/models/user.dart';

class LoginModel {
  bool loadingLogin = false;
  String email = '';
  String password = '';
  String? loginError;
  bool loginSuccess = false;

  User? userLoggedIn;
}
