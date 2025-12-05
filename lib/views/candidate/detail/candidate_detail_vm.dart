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

    value.descriptionCtrl = TextEditingController(text: candidate.description);
    value.birthDateCtrl =
        TextEditingController(text: candidate.birthDate ?? "");
    value.phoneCtrl = TextEditingController(text: candidate.phone ?? "");
    value.yearsExperienceCtrl = TextEditingController(
      text: candidate.yearsExperience?.toString() ?? "",
    );
    value.locationCtrl = TextEditingController(text: candidate.location ?? "");
    value.currentPositionCtrl = TextEditingController(
      text: candidate.currentPosition ?? "",
    );
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
        resume: value.candidate.description);

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

  void toggleEditingBirthDate() {
    value.isEditingBirthDate = !value.isEditingBirthDate;
    notifyListeners();
  }

  void toggleEditingPhone() {
    value.isEditingPhone = !value.isEditingPhone;
    notifyListeners();
  }

  void toggleEditingYearsExperience() {
    value.isEditingYearsExperience = !value.isEditingYearsExperience;
    notifyListeners();
  }

  void toggleEditingLocation() {
    value.isEditingLocation = !value.isEditingLocation;
    notifyListeners();
  }

  void toggleEditingCurrentPosition() {
    value.isEditingCurrentPosition = !value.isEditingCurrentPosition;
    notifyListeners();
  }
}
