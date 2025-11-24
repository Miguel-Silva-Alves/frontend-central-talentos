import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/user.dart';
import 'package:frontend_central_talentos/provider/user_logged_provider.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_model.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_parameter.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_vm.dart';

class TopBarWidget extends StatefulWidget {
  final TopbarParameter parameter;

  const TopBarWidget({super.key, required this.parameter});

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  late TopbarVm vm;

  @override
  void initState() {
    super.initState();
    vm = TopbarVm();

    final currentUser = UserProvider().user;

    if (currentUser != null) {
      vm.value.partner = currentUser.urlPartner;
      vm.value.user = currentUser;
    } else {
      // Evita crash e deixa TopBar mostrar uma versão básica
      vm.value.partner = null;
      vm.value.user = User.empty(); // ou algo leve
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TopbarModel>(
      valueListenable: vm,
      builder: (context, model, _) {
        if (model.goTo != null) {
          // Navega
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed(model.goTo!, arguments: model.args);
          });
        }
        return Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 4,
              )
            ],
          ),
          child: Row(
            children: [
              if (widget.parameter.showgoback && widget.parameter.goBack != '')
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pushNamed(widget.parameter.goBack!,
                        arguments: widget.parameter.args);
                  },
                ),
              if (!widget.parameter.showgoback)
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: widget.parameter.onMenuPressed,
                ),
              // --- Logo retangular + nome da academia ---
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                    model.partner != null && model.partner!.startsWith('https')
                        ? Image.network(
                            model.partner!,
                            height: 48,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/logo-empresa.png',
                            height: 48,
                            width: 150,
                            // fit: BoxFit.cover,
                          ),
              ),
              const SizedBox(width: 16),

              const Spacer(),

              // --- Avatar circular do usuário + nome ---
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: model.user.photoUrl.startsWith('https')
                        ? NetworkImage(model.user.photoUrl)
                        : AssetImage(model.user.photoUrl) as ImageProvider,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    model.user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Menu para opções como "Logout"
                  PopupMenuButton<String>(
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    onSelected: (value) {
                      if (value == 'logout') {
                        // fazer logout
                        vm.logout();
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: 'logout',
                        child: Text('Sair'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
