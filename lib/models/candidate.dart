class Candidate {
  final String photoUrl;
  final String name;
  final String email;
  final String description;
  final List<String> keySkills;

  Candidate({
    required this.photoUrl,
    required this.name,
    required this.email,
    required this.description,
    required this.keySkills,
  });

  Candidate copyWith({
    String? photoUrl,
    String? name,
    String? email,
    String? description,
    List<String>? keySkills,
  }) {
    return Candidate(
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      description: description ?? this.description,
      keySkills: keySkills ?? this.keySkills,
    );
  }
}
