import 'package:frontend_central_talentos/auth/role.dart';
import 'package:frontend_central_talentos/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  // Singleton
  static final UserProvider _instance = UserProvider._internal();
  factory UserProvider() => _instance;
  UserProvider._internal();

  User? _user;
  User? get user => _user;
  bool get isLoggedIn => _user != null;

  // Login
  void login(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  // Logout
  void logout() {
    _user = null;
    notifyListeners();
  }

  // Verifica se o usuário tem uma role específica
  bool hasRole(Role role) {
    return _user?.roles.contains(role) ?? false;
  }
}
