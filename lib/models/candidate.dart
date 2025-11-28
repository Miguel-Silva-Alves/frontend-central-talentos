class Candidate {
  int? id;

  // Já existentes
  final String photoUrl;
  final String name;
  final String email;
  final String description;
  final List<String> keySkills;
  final double matchScore;

  // Novos campos opcionais
  final String? birthDate; // "1999-01-01"
  final String? phone; // "+551199999999"
  final int? yearsExperience; // 5
  final String? location; // "São Paulo"
  final String? currentPosition; // "Desenvolvedor"
  final List<int>? files; // [8]

  Candidate({
    required this.photoUrl,
    required this.name,
    required this.email,
    required this.description,
    required this.keySkills,
    this.matchScore = 0.0,
    this.id,

    // novos:
    this.birthDate,
    this.phone,
    this.yearsExperience,
    this.location,
    this.currentPosition,
    this.files,
  });

  Candidate copyWith({
    String? photoUrl,
    String? name,
    String? email,
    String? description,
    List<String>? keySkills,
    double? matchScore,
    int? id,

    // novos
    String? birthDate,
    String? phone,
    int? yearsExperience,
    String? location,
    String? currentPosition,
    List<int>? files,
  }) {
    return Candidate(
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      description: description ?? this.description,
      keySkills: keySkills ?? this.keySkills,
      matchScore: matchScore ?? this.matchScore,
      id: id ?? this.id,
      birthDate: birthDate ?? this.birthDate,
      phone: phone ?? this.phone,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      location: location ?? this.location,
      currentPosition: currentPosition ?? this.currentPosition,
      files: files ?? this.files,
    );
  }

  // -------------------------------
  // FROM JSON
  // -------------------------------
  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json["id"],
      photoUrl: json["photoUrl"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      description: json["candidate_description"] ?? "",
      keySkills: List<String>.from(json["key_skills"] ?? []),
      matchScore: (json["score"] ?? 0.0).toDouble(),

      // novos campos:
      birthDate: json["birth_date"],
      phone: json["phone"],
      yearsExperience: json["years_experience"],
      location: json["location"],
      currentPosition: json["current_position"],
      files: json["files"] != null ? List<int>.from(json["files"]) : null,
    );
  }

  // -------------------------------
  // TO JSON
  // -------------------------------
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "photoUrl": photoUrl,
      "name": name,
      "email": email,
      "candidate_description": description,
      "key_skills": keySkills,
      "score": matchScore,

      // novos
      "birth_date": birthDate,
      "phone": phone,
      "years_experience": yearsExperience,
      "location": location,
      "current_position": currentPosition,
      "files": files,
    };
  }
}
