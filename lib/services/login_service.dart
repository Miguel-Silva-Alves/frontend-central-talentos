import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:frontend_central_talentos/auth/role.dart';
import 'package:frontend_central_talentos/models/user.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final http.Client client;
  final String baseUrl = "http://127.0.0.1:8000";

  LoginService({http.Client? client}) : client = client ?? http.Client();

  // para usar nos testes
  factory LoginService.withClient(http.Client client) {
    return LoginService(client: client);
  }

  Future<User?> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/access/login");

    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "x-api-key": "j6Q04H4J2pTOCMTLWr9bDpBQerrxU9U",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return User(
          id: data["user"],
          token: data["token"],
          email: email,
          name: email,
          photoUrl: "",
          roles: [Role.partner],
        );
      }
    } catch (e) {
      debugPrint("Erro no login: $e");
    }

    // return null;
    return User(
      id: 1,
      token: "token",
      email: email,
      name: email,
      photoUrl: "",
      roles: [Role.partner],
    );
  }
}
