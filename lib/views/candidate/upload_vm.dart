import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:frontend_central_talentos/provider/user_logged_provider.dart';
import 'package:frontend_central_talentos/services/candidate_service.dart';

import 'upload_model.dart';

class UploadVm extends ValueNotifier<UploadModel> {
  late CandidateService candidatesService;
  UploadVm() : super(UploadModel()) {
    candidatesService = CandidateService();
  }

  Uint8List? fileBytes;
  String? pickedFileName;

  void toggleSidebar() {
    value = value.copyWith(showSidebar: !value.showSidebar);
  }

  Future<void> pickFile() async {
    value = value.copyWith(isLoading: true);

    try {
      final result = await FilePicker.platform.pickFiles(
        withData: true,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        value = value.copyWith(isLoading: false);
        return;
      }

      final picked = result.files.first;

      if (picked.bytes == null) {
        value = value.copyWith(
          isLoading: false,
          errorMessage: 'Falha ao carregar bytes do arquivo.',
        );
        return;
      }

      fileBytes = picked.bytes;
      pickedFileName = picked.name;

      // adiciona na lista
      final updatedList = List<String>.from(value.uploadedFiles)
        ..add(picked.name);

      value = value.copyWith(
        fileName: picked.name,
        uploadedFiles: updatedList,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        errorMessage: 'Erro ao selecionar arquivo: $e',
      );
    }
  }

  void removeFile(String fileName) {
    final updatedList = List<String>.from(value.uploadedFiles)
      ..remove(fileName);

    value = value.copyWith(
      uploadedFiles: updatedList,
    );
  }

  void changeSection(UploadSection section) async {
    // Se for a LISTAGEM → carrega os candidatos
    if (section == UploadSection.list) {
      value.isLoading = true;
      notifyListeners();

      await loadCandidates();

      value.isLoading = false;
    }

    value.section = section;
    notifyListeners();
  }

  void openCandidate(Candidate candidate) {
    value.selectedCandidate = candidate;
    value.section = UploadSection.detail;
    notifyListeners();
  }

  void backToList() {
    value.section = UploadSection.list;
    notifyListeners();
  }

  Future<void> loadCandidates() async {
    value.isLoading = true;
    notifyListeners();

    final token = UserProvider().user?.token ?? "";
    final results = await candidatesService.listCandidates(
      token: token,
    );

    value.candidates = results;

    value.isLoading = false;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // ENVIO DO ARQUIVO ➝ PROCESSAMENTO ➝ CANDIDATO
  // ---------------------------------------------------------------------------
  Future<void> processCandidate() async {
    if (fileBytes == null || pickedFileName == null) {
      debugPrint("processCandidate: Nenhum arquivo selecionado");
      value = value.copyWith(errorMessage: "Nenhum arquivo selecionado");
      return;
    }

    value = value.copyWith(isLoading: true);
    notifyListeners();

    try {
      // 1) Chamar API
      final token = UserProvider().user?.token ?? "";
      final result = await candidatesService.sendCandidateFile(
        token: token,
        fileBytes: fileBytes!,
        fileName: value.fileName!,
      );

      if (result == null) {
        value = value.copyWith(
          isLoading: false,
          errorMessage: "Falha ao enviar arquivo.",
        );
        return;
      }

      // 2) Transformar retorno em Candidate
      final fileJson = result["file"]["extracted_info"] as Map<String, dynamic>;

      final candidate = Candidate(
          name: fileJson["info"]["nome"] ?? "",
          email: fileJson["info"]["email"] ?? "",
          description: fileJson["info"]["resumo"] ?? "",
          keySkills: List<String>.from(fileJson["info"]["habilidades"] ?? [])
              .sublist(0, 5),
          photoUrl: "",
          location: fileJson["info"]["location"] ?? "",
          birthDate: fileJson["info"]["idade"] ?? "",
          phone: fileJson["info"]["telefone"] ?? "",
          yearsExperience: fileJson["info"]["anos_experiencia"] ?? 0,
          matchScore: 0.0,
          files: [result["file"]["id"]]);

      // 4) Limpar estado
      value = value.copyWith(
        fileName: null,
        uploadedFiles: [],
        isLoading: false,
        errorMessage: null,
      );

      // 5) Abrir detalhes
      openCandidate(candidate);
    } catch (e) {
      debugPrint("processCandidate: Erro no processamento: $e");
      value = value.copyWith(
        isLoading: false,
        errorMessage: "Erro no processamento: $e",
      );
    }
  }
}
