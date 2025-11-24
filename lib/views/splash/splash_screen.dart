import 'package:frontend_central_talentos/views/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Configuração da animação
    try {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      );

      _animation = Tween<double>(begin: 0.5, end: 1.0)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

      _controller.forward();

      // Navega para a tela principal após 2.5 segundos
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, AppRoutes.login);
      });
    } catch (e, stackTrace) {
      // logMessage("Erro fatal: $e\n$stackTrace");
      debugPrint("Erro fatal: $e\n$stackTrace");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 5, 5, 5), // Altere conforme sua identidade visual
        body: SizedBox.expand(
          child: Center(
            child: ScaleTransition(
              scale: _animation,
              child: FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  'assets/images/logo-empresa.png',
                  width: 350, // Ajuste o tamanho conforme necessário
                ),
              ),
            ),
          ),
        ));
  }
}
