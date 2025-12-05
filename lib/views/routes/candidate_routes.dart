import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:frontend_central_talentos/views/candidate/upload_screen.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';

Map<String, WidgetBuilder> candidateRoutes = {
  AppRoutes.candidateInput: (context) {
    Candidate? candidate;
    if (ModalRoute.of(context)?.settings.arguments is Candidate) {
      candidate = ModalRoute.of(context)?.settings.arguments as Candidate;
    }
    return UploadScreen(candidate: candidate);
  }
};
