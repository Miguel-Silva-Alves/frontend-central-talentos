import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:http/http.dart' as http;

class AiService {
  final http.Client client;
  final String baseUrl = "http://127.0.0.1:8000";

  AiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Candidate>> searchCandidates({
    required String token,
    required String prompt,
  }) async {
    final url = Uri.parse("$baseUrl/ai/querie/prompt");
    debugPrint("AIService: Enviando prompt: $prompt, token: $token");

    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"prompt": prompt}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        final List results = data["results"] ?? [];

        return results.map((item) => Candidate.fromJson(item)).toList();
      } else {
        debugPrint("Erro na API: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Erro no searchCandidates: $e");
    }

    return [];
  }
}
