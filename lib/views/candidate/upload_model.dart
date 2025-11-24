class UploadModel {
  final bool showSidebar;
  final bool isLoading;
  final String? fileName;
  final List<String> uploadedFiles;
  final String? errorMessage;

  UploadModel({
    this.showSidebar = true,
    this.isLoading = false,
    this.fileName,
    this.uploadedFiles = const [],
    this.errorMessage,
  });

  UploadModel copyWith({
    bool? showSidebar,
    bool? isLoading,
    String? fileName,
    List<String>? uploadedFiles,
    String? errorMessage,
  }) {
    return UploadModel(
      showSidebar: showSidebar ?? this.showSidebar,
      isLoading: isLoading ?? this.isLoading,
      fileName: fileName ?? this.fileName,
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
