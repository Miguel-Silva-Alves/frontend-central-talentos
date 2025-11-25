import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';

import 'candidate_detail_model.dart';

class CandidateDetailVm extends ValueNotifier<CandidateDetailModel> {
  CandidateDetailVm(Candidate candidate)
      : super(CandidateDetailModel(candidate: candidate));

  Future<void> saveCandidate() async {
    value = value.copyWith(isSaving: true, saved: false);
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // simulação API

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
