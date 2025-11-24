import 'package:frontend_central_talentos/models/candidate.dart';

enum UploadSection { input, list, detail }

class UploadModel {
  final bool showSidebar;
  bool isLoading;
  final String? fileName;
  final List<String> uploadedFiles;
  final String? errorMessage;
  UploadSection section;
  // Para detalhes
  Candidate? selectedCandidate;
  List<Candidate> candidates = [];

  UploadModel({
    this.showSidebar = true,
    this.isLoading = false,
    this.fileName,
    this.uploadedFiles = const [],
    this.errorMessage,
    this.selectedCandidate,
    this.section = UploadSection.input,
    this.candidates = const [],
  });

  UploadModel copyWith({
    bool? showSidebar,
    bool? isLoading,
    String? fileName,
    List<String>? uploadedFiles,
    String? errorMessage,
    UploadSection? section,
    Candidate? selectedCandidate,
    List<Candidate>? candidates,
  }) {
    return UploadModel(
      showSidebar: showSidebar ?? this.showSidebar,
      isLoading: isLoading ?? this.isLoading,
      fileName: fileName ?? this.fileName,
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
      errorMessage: errorMessage ?? this.errorMessage,
      section: section ?? this.section,
      candidates: candidates ?? this.candidates,
      selectedCandidate: selectedCandidate ?? this.selectedCandidate,
    );
  }
}
