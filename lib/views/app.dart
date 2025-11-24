import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';
import 'package:frontend_central_talentos/views/routes/candidate_routes.dart';
import 'package:frontend_central_talentos/views/routes/home_routes.dart';
import 'package:frontend_central_talentos/views/routes/login_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coresafe RH',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        final builder = {
          ...homeRoutes,
          ...loginRoutes,
          ...candidateRoutes,
        }[settings.name];

        if (builder != null) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                builder(context),
            settings: settings,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration:
                const Duration(milliseconds: 300), // tempo da animação
          );
        }

        return null;
      },
      initialRoute: AppRoutes.splash,
    );
  }
}
