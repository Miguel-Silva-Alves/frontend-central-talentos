import 'package:frontend_central_talentos/models/candidate.dart';

class CandidateDetailModel {
  final Candidate candidate;
  final bool isSaving;
  final bool saved;
  final bool isEditingDescription;

  CandidateDetailModel({
    required this.candidate,
    this.isSaving = false,
    this.saved = false,
    this.isEditingDescription = false,
  });

  CandidateDetailModel copyWith({
    Candidate? candidate,
    bool? isSaving,
    bool? saved,
    bool? isEditingDescription,
  }) {
    return CandidateDetailModel(
      candidate: candidate ?? this.candidate,
      isSaving: isSaving ?? this.isSaving,
      saved: saved ?? this.saved,
      isEditingDescription: isEditingDescription ?? this.isEditingDescription,
    );
  }
}
