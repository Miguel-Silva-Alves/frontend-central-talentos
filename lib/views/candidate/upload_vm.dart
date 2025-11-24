import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';

import 'upload_model.dart';

class UploadVm extends ValueNotifier<UploadModel> {
  UploadVm() : super(UploadModel());

  Uint8List? fileBytes;

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

    // Simula API HTTP
    await Future.delayed(const Duration(seconds: 1));

    value.candidates = [
      Candidate(
        photoUrl: "https://i.pravatar.cc/150?img=1",
        name: "João Silva",
        email: "joao.silva@example.com",
        description: "Desenvolvedor Full Stack com 5 anos de experiência.",
      ),
      Candidate(
        photoUrl: "https://i.pravatar.cc/150?img=2",
        name: "Maria Costa",
        email: "maria.costa@example.com",
        description: "Designer UI/UX apaixonada por experiência do usuário.",
      ),
      Candidate(
        photoUrl: "https://i.pravatar.cc/150?img=3",
        name: "Lucas Rocha",
        email: "lucas.rocha@example.com",
        description: "Especialista em automação e integrações.",
      ),
    ];

    value.isLoading = false;
    notifyListeners();
  }
}
