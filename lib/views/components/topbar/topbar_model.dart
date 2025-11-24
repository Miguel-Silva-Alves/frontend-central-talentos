import 'package:frontend_central_talentos/models/user.dart';

class TopbarModel {
  late String? partner;
  late User user;

  String? goTo;
  Object? args;
  bool reconnectToWebSocket = false;
}
