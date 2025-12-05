import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:http/http.dart' as http;

class CandidateService {
  final http.Client client;
  final String baseUrl = "http://127.0.0.1:8000";

  CandidateService({http.Client? client}) : client = client ?? http.Client();

  // ------------------------------
  // LIST CANDIDATES
  // ------------------------------
  Future<List<Candidate>> listCandidates({
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/company/candidates");

    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        final List results = data["candidates"] ?? [];

        return results.map((item) => Candidate.fromJson(item)).toList();
      } else {
        debugPrint("Erro na API: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Erro no listCandidates: $e");
    }

    return [];
  }

  // ------------------------------
  // CREATE CANDIDATE
  // ------------------------------
  Future<Map<String, dynamic>?> createCandidate({
    required String token,
    required String name,
    String? birthDate,
    required String email,
    String? phone,
    int? yearsExperience,
    String? location,
    String? currentPosition,
    String? resume,
    required List<int> files,
  }) async {
    final url = Uri.parse("$baseUrl/company/candidates");

    final payload = {
      "name": name,
      "birth_date": birthDate,
      "email": email,
      "phone": phone,
      "years_experience": yearsExperience,
      "location": location,
      "current_position": currentPosition,
      "files": files,
      "profile_resume": resume
    };

    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        debugPrint(
          "Erro no createCandidate: ${response.statusCode} -> ${response.body}",
        );
      }
    } catch (e) {
      debugPrint("Erro no createCandidate: $e");
    }

    return null;
  }

  // ------------------------------
  // SEND FILE
  // ------------------------------
  Future<Map<String, dynamic>?> sendCandidateFile({
    required String token,
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    final url = Uri.parse("$baseUrl/rh/file/upload");

    try {
      final request = http.MultipartRequest("POST", url);
      request.headers["Authorization"] = "Bearer $token";

      // Compatível 100% com Web + Mobile
      final multipartFile = http.MultipartFile.fromBytes(
        "file",
        fileBytes,
        filename: fileName,
      );

      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        return decoded;
      } else {
        debugPrint("Erro no upload: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      debugPrint("Erro no sendCandidateFile: $e");
    }

    return null;
  }
}
