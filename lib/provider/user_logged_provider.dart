import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  // Singleton
  static final UserProvider _instance = UserProvider._internal();
  factory UserProvider() => _instance;
  UserProvider._internal();

  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  /// Inicializa carregando o usuário salvo (se existir)
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString("user");

    if (savedUser != null) {
      try {
        _user = User.fromJson(jsonDecode(savedUser));
        notifyListeners();
      } catch (e) {
        // Se o JSON estiver quebrado, limpa
        prefs.remove("user");
      }
    }
  }

  /// Login — salva o usuário em memória e no SharedPreferences
  Future<void> login(User newUser) async {
    _user = newUser;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(newUser.toJson()));

    notifyListeners();
  }

  /// Logout — limpa memória e SharedPreferences
  Future<void> logout() async {
    _user = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");

    notifyListeners();
  }
}
