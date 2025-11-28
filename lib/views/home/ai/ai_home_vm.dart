import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/provider/user_logged_provider.dart';
import 'package:frontend_central_talentos/services/ai_service.dart';
import 'package:frontend_central_talentos/views/home/ai/ai_home_model.dart';

class AIHomeVm extends ValueNotifier<AiHomeModel> {
  late AiService aiService;
  AIHomeVm() : super(AiHomeModel()) {
    aiService = AiService();
  }

  void toggleSidebar() {
    value.showSidebar = !value.showSidebar;
    notifyListeners();
  }

  Future<void> searchCandidates(String prompt) async {
    value = value.copyWith(isLoading: true);
    notifyListeners();

    final token = UserProvider().user?.token ?? "";
    final results = await aiService.searchCandidates(
      token: token,
      prompt: prompt,
    );
    value = value.copyWith(
      candidates: results,
      isLoading: false,
    );

    notifyListeners();
  }
}
