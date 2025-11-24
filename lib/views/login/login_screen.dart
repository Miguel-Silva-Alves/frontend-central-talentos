import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/provider/user_logged_provider.dart';
import 'package:frontend_central_talentos/views/login/login_model.dart';
import 'package:frontend_central_talentos/views/login/login_vm.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // View Model
  late LoginVm vm;

  @override
  void initState() {
    super.initState();
    vm = LoginVm();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LoginModel>(
      valueListenable: vm,
      builder: (context, model, _) {
        if (model.loginSuccess && model.userLoggedIn != null) {
          final user = model.userLoggedIn!;
          UserProvider().login(user); // Atualiza o usuário logado

          model.loginSuccess = false; // Limpa o sucesso do login
          model.userLoggedIn = null; // Limpa o usuário logado

          // // WebSocketProvider
          // final wsProvider =
          //     Provider.of<WebSocketProvider>(context, listen: false);

          // wsProvider.connect(
          //   "${Settings.websocketUrl}/v1/connection/academy-${user.academies.first.id}?mult=true", // seu host
          // );
          // Navega
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed(AppRoutes.home);
          });
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E1E1E), Color(0xFF3A3A3A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo-empresa.png',
                    height: 100,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    onChanged: (value) => model.email = value,
                    cursorColor: const Color.fromARGB(
                        255, 255, 153, 19), // cor laranja igual ao foco
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 153, 19)),
                      ),
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 153, 19),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) => model.password = value,
                    cursorColor: const Color.fromARGB(
                        255, 255, 153, 19), // cor laranja igual ao foco
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 153, 19)),
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 153, 19),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // AQUI: exibe o erro se existir
                  if (model.loginError != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        model.loginError!,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: model.loadingLogin ? null : () => vm.login(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: model.loadingLogin
                            ? Colors.grey
                            : const Color.fromARGB(255, 255, 153,
                                19), // cor laranja igual ao foco,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: model.loadingLogin
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
