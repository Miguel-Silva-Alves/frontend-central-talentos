import 'package:frontend_central_talentos/auth/role.dart';

class User {
  int id;
  String token;
  String name;
  String photoUrl;
  String email;
  List<Role> roles; // Default role is student
  String? urlPartner;

  // Constructor
  User(
      {required this.id,
      required this.token,
      required this.name,
      required this.photoUrl,
      required this.email,
      required this.roles,
      this.urlPartner});

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
}
