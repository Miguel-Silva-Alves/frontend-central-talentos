import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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

  void changeSection(UploadSection section) {
    value.section = section;
    notifyListeners();
  }

  void openCandidate(String name) {
    value.selectedCandidate = name;
    value.section = UploadSection.detail;
    notifyListeners();
  }

  void backToList() {
    value.section = UploadSection.list;
    notifyListeners();
  }
}
