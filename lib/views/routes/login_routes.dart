import 'package:frontend_central_talentos/views/login/login_screen.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> loginRoutes = {
  AppRoutes.login: (context) => const LoginScreen()
};
