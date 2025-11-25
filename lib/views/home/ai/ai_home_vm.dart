import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:frontend_central_talentos/views/home/ai/ai_home_model.dart';

class AIHomeVm extends ValueNotifier<AiHomeModel> {
  AIHomeVm() : super(AiHomeModel());

  void toggleSidebar() {
    value.showSidebar = !value.showSidebar;
    notifyListeners();
  }

  Future<void> searchCandidates(String prompt) async {
    value = value.copyWith(isLoading: true);
    notifyListeners();

    // Simula requisição HTTP de IA
    await Future.delayed(const Duration(seconds: 2));

    // Resultado mockado
    final mockList = [
      Candidate(
        photoUrl: "https://i.pravatar.cc/150?img=11",
        name: "Fernanda Alves",
        email: "fernanda.alves@example.com",
        description: "Especialista em comunicação e liderança.",
        keySkills: [
          "Liderança",
          "Comunicação",
          "Mediação",
          "Gestão de equipes"
        ],
      ),
      Candidate(
        photoUrl: "https://i.pravatar.cc/150?img=12",
        name: "Rafael Torres",
        email: "rafael.torres@example.com",
        description: "Engenheiro de software focado em automação.",
        keySkills: ["Dart", "Flutter", "CI/CD", "Linux", "Automação"],
      ),
      Candidate(
        photoUrl: "https://i.pravatar.cc/150?img=13",
        name: "Juliana Martins",
        email: "juliana.martins@example.com",
        description: "Profissional de RH focada em cultura e treinamento.",
        keySkills: ["RH", "Treinamento", "Cultura Organizacional"],
      ),
    ];

    value = value.copyWith(
      candidates: mockList,
      isLoading: false,
    );

    notifyListeners();
  }
}
