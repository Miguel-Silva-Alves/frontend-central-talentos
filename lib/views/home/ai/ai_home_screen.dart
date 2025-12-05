import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/views/components/sidebar/sidebar_component.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_component.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_parameter.dart';
import 'package:frontend_central_talentos/views/home/ai/ai_home_model.dart';
import 'package:frontend_central_talentos/views/home/ai/ai_home_vm.dart';
import 'package:frontend_central_talentos/views/home/ai/components/ai_card_component.dart';

class AIHomeScreen extends StatefulWidget {
  const AIHomeScreen({super.key});

  @override
  State<AIHomeScreen> createState() => _AIHomeScreenState();
}

class _AIHomeScreenState extends State<AIHomeScreen> {
  final TextEditingController promptController = TextEditingController();
  late AIHomeVm vm;

  @override
  void initState() {
    super.initState();
    vm = AIHomeVm();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AiHomeModel>(
        valueListenable: vm,
        builder: (context, model, _) {
          if (model.goTo != null) {
            final goTo = model.goTo!;
            model.goTo = null;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushNamed(goTo, arguments: model.argument);
            });
          }

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: TopBarWidget(
                parameter: TopbarParameter(
                  onMenuPressed: () {},
                  goBack: null,
                ),
              ),
            ),
            body: Row(
              children: [
                const SideBarWidget(selectedItem: "IA"),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _titleGradient(),
                          const SizedBox(height: 20),
                          _subTitle(),
                          const SizedBox(height: 50),
                          _promptBox(),
                          if (model.isLoading)
                            const Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          if (!model.isLoading && model.candidates.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Column(
                                children: model.candidates
                                    .map((c) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: AiCandidateCard(
                                            candidate: c,
                                            onTap: () =>
                                                vm.openCandidateDetail(c),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // --------------------------
  // TÍTULO COM GRADIENTE
  // --------------------------
  Widget _titleGradient() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            Color(0xFF144EE3),
            Color(0xFFEB568E),
            Color(0xFFA353AA),
            Color(0xFF144EE3),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      child: const Text(
        "Procure a Pessoa Certa para sua Empresa :)",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 60,
          height: 1.3,
          fontWeight: FontWeight.w800,
          color: Colors.white, // necessário para shader máscara
        ),
      ),
    );
  }

  // --------------------------
  // SUBTÍTULO
  // --------------------------
  Widget _subTitle() {
    return const SizedBox(
      width: 634,
      child: Text(
        "Linkly is an efficient and easy-to-use URL shortening service that streamlines your online experience.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          height: 1.5,
          color: Color(0xFFC9CED6),
        ),
      ),
    );
  }

  // --------------------------
  // INPUT + BOTÃO
  // --------------------------
  Widget _promptBox() {
    return Container(
      width: 659,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF181E29),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(48),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.link,
              color: Color(0xFFC9CED6),
              size: 24,
            ),

            const SizedBox(width: 20),

            // ------------------------------------------------
            // TEXTFIELD EXPANSÍVEL
            // ------------------------------------------------
            Expanded(
              child: TextField(
                controller: promptController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Coloque as características que você busca...",
                  hintStyle: TextStyle(
                    color: Color(0xFFC9CED6),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),

            // ------------------------------------------------
            // BOTÃO QUE DESCE JUNTO COM O INPUT
            // ------------------------------------------------
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () async {
                  final text = promptController.text.trim();
                  if (text.isEmpty) return;

                  await vm.searchCandidates(text);
                },
                child: Container(
                  width: 178,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF144EE3),
                    borderRadius: BorderRadius.circular(48),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF144EE3).withOpacity(0.38),
                        blurRadius: 22,
                        offset: const Offset(10, 9),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Pesquisar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
