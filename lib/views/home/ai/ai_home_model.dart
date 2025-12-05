import 'package:frontend_central_talentos/models/candidate.dart';

class AiHomeModel {
  String? goTo;
  Object? argument;
  bool showSidebar;
  List<Candidate> candidates;
  bool isLoading;

  AiHomeModel({
    this.goTo,
    this.showSidebar = true,
    this.candidates = const [],
    this.isLoading = false,
  });

  AiHomeModel copyWith({
    String? goTo,
    bool? showSidebar,
    List<Candidate>? candidates,
    bool? isLoading,
  }) {
    return AiHomeModel(
      goTo: goTo ?? this.goTo,
      showSidebar: showSidebar ?? this.showSidebar,
      candidates: candidates ?? this.candidates,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
