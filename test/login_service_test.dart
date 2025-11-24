import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:frontend_central_talentos/services/login_service.dart';
import 'package:frontend_central_talentos/models/user.dart';

void main() {
  group('LoginService', () {
    test('deve retornar User válido quando login for bem-sucedido', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.toString(), "http://localhost:8000/access/login");
        expect(request.method, "POST");
        expect(request.headers["Content-Type"], contains("application/json"));
        expect(request.headers["x-api-key"], "j6Q04H4J2pTOCMTLWr9bDpBQerrxU9U");

        final body = jsonDecode(request.body);
        expect(body["email"], "teste@empresa.com");
        expect(body["password"], "123456");

        return Response(
            jsonEncode({
              "id": 10,
              "token": "539241ea-627a-4b50-9938-403e2c98253d",
              "iat": "2025-11-17T18:50:58.156752-03:00",
              "expires_at": "2025-11-17T19:50:58.156761-03:00",
              "user": 2,
              "message": "ok"
            }),
            200);
      });

      final service = LoginService.withClient(mockClient);

      final user = await service.login("teste@empresa.com", "123456");

      expect(user, isA<User>());
      expect(user?.token, "539241ea-627a-4b50-9938-403e2c98253d");
      expect(user?.id, 2);
    });

    test('deve retornar null quando API retornar erro', () async {
      final mockClient = MockClient((request) async {
        return Response('{"message": "invalid credentials"}', 401);
      });

      final service = LoginService.withClient(mockClient);

      final user = await service.login("x@x.com", "errado");

      expect(user, isNull);
    });
  });
}
