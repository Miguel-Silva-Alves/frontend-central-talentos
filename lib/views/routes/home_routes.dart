import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/views/home/ai/ai_home_screen.dart';
import 'package:frontend_central_talentos/views/home/home_screen.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';
import 'package:frontend_central_talentos/views/splash/splash_screen.dart';

Map<String, WidgetBuilder> homeRoutes = {
  AppRoutes.homeDashboard: (context) {
    return const HomeScreen();
  },
  AppRoutes.home: (context) {
    return const AIHomeScreen();
  },
  AppRoutes.splash: (context) => SplashScreen()
};
