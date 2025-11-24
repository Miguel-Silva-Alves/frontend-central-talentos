import 'package:frontend_central_talentos/views/home/home_model.dart';
import 'package:flutter/material.dart';

class HomeVm extends ValueNotifier<HomeModel> {
  HomeVm() : super(HomeModel());

  void toggleSidebar() {
    value.showSidebar = !value.showSidebar;
    notifyListeners();
  }
}
