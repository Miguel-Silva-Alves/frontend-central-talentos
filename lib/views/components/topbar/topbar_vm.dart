import 'package:frontend_central_talentos/provider/user_logged_provider.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_model.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';
import 'package:flutter/material.dart';

class TopbarVm extends ValueNotifier<TopbarModel> {
  TopbarVm() : super(TopbarModel());

  void logout() {
    // Logout first
    UserProvider().logout();

    value.goTo = AppRoutes.login;
    notifyListeners();
  }
}
