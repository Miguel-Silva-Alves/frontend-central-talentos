import 'package:frontend_central_talentos/auth/role.dart';

class User {
  int id;
  String token;
  String name;
  String photoUrl;
  String email;
  List<Role> roles;
  String? urlPartner;

  User({
    required this.id,
    required this.token,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.roles,
    this.urlPartner,
  });

  static User empty() {
    return User(
      id: 0,
      token: "",
      name: "Guest",
      photoUrl: "",
      email: "",
      roles: [],
    );
  }

  // ---------- FROM JSON ----------
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      token: json['token'] ?? "",
      name: json['name'] ?? "",
      photoUrl: json['photoUrl'] ?? "",
      email: json['email'] ?? "",
      roles: (json['roles'] as List<dynamic>? ?? [])
          .map((r) => roleFromString(r))
          .toList(),
      urlPartner: json['urlPartner'],
    );
  }

  // ---------- TO JSON ----------
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "token": token,
      "name": name,
      "photoUrl": photoUrl,
      "email": email,
      "roles": roles.map(roleToString).toList(),
      "urlPartner": urlPartner,
    };
  }
}
