import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/views/candidate/upload_screen.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';

Map<String, WidgetBuilder> candidateRoutes = {
  AppRoutes.candidateInput: (context) {
    return const UploadScreen();
  }
};
