import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:frontend_central_talentos/provider/user_logged_provider.dart';
import 'package:frontend_central_talentos/services/candidate_service.dart';

import 'candidate_detail_model.dart';

class CandidateDetailVm extends ValueNotifier<CandidateDetailModel> {
  late CandidateService candidateService;
  CandidateDetailVm(Candidate candidate)
      : super(CandidateDetailModel(candidate: candidate)) {
    candidateService = CandidateService();
  }

  Future<void> saveCandidate() async {
    value = value.copyWith(isSaving: true, saved: false);
    notifyListeners();

    final token = UserProvider().user?.token ?? "";
    await candidateService.createCandidate(
      token: token,
      name: value.candidate.name,
      email: value.candidate.email,
      phone: value.candidate.phone,
      yearsExperience: value.candidate.yearsExperience,
      location: value.candidate.location,
      currentPosition: value.candidate.currentPosition,
      files: value.candidate.files ?? [],
    );

    value = value.copyWith(isSaving: false, saved: true);
    notifyListeners();
  }

  void toggleEditingDescription() {
    value = value.copyWith(isEditingDescription: !value.isEditingDescription);
    notifyListeners();
  }

  void updateDescription(String newText) {
    value = value.copyWith(
      candidate: value.candidate.copyWith(description: newText),
    );
    notifyListeners();
  }

  void removeSkill(String skill) {
    final updatedSkills =
        value.candidate.keySkills.where((s) => s != skill).toList();

    value = value.copyWith(
      candidate: value.candidate.copyWith(keySkills: updatedSkills),
    );
    notifyListeners();
  }
}
