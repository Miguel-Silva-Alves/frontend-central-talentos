import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/provider/user_logged_provider.dart';
import 'package:frontend_central_talentos/views/app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userProvider = UserProvider();
  await userProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const App(),
    ),
  );
}
