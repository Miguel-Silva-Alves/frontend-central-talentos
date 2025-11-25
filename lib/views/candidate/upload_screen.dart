import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:frontend_central_talentos/views/candidate/widgets/candidate_list.dart';
import 'package:frontend_central_talentos/views/components/sidebar/sidebar_component.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_component.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_parameter.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';

import 'upload_model.dart';
import 'upload_vm.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late UploadVm vm;

  @override
  void initState() {
    super.initState();
    vm = UploadVm();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UploadModel>(
      valueListenable: vm,
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: const Color(0xFF0E0E0F),

          // -----------------------------
          //       TOP BAR
          // -----------------------------
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: TopBarWidget(
              parameter: TopbarParameter(
                onMenuPressed: vm.toggleSidebar,
                goBack: AppRoutes.home,
              ),
            ),
          ),

          // -----------------------------
          //       BODY + SIDEBAR
          // -----------------------------
          body: Row(
            children: [
              if (model.showSidebar)
                const SideBarWidget(selectedItem: "Uploads"),

              // CONTEÚDO PRINCIPAL
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _internalMenu(model),
                      Expanded(child: _internalContent(model)),
                      // -----------------------------
                      //     BOTÃO PRINCIPAL
                      // -----------------------------
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _internalMenu(UploadModel model) {
    return Container(
      height: 50,
      color: const Color(0xFF101213),
      child: Row(
        children: [
          _menuTab(
            label: "Cadastrar",
            active: model.section == UploadSection.input,
            onTap: () => vm.changeSection(UploadSection.input),
          ),
          _menuTab(
            label: "Candidatos",
            active: model.section == UploadSection.list,
            onTap: () => vm.changeSection(UploadSection.list),
          ),
          _menuTab(
            label: "Detalhes",
            active: model.section == UploadSection.detail,
            onTap: () => {},
          ),
        ],
      ),
    );
  }

  Widget _internalContent(UploadModel model) {
    switch (model.section) {
      case UploadSection.input:
        return _candidateInput(model);
      case UploadSection.list:
        return CandidateListWidget(candidates: model.candidates, vm: vm);
      case UploadSection.detail:
        if (model.selectedCandidate != null) {
          return _candidateDetail(model.selectedCandidate!);
        }
        // fallback
        return const Center(
          child: Text(
            "Nenhum candidato selecionado",
            style: TextStyle(color: Colors.white70),
          ),
        );
    }
  }

  Widget _candidateInput(UploadModel model) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: vm.pickFile,
            child: Container(
              width: 532,
              height: 259,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF101213),
                border: Border.all(color: const Color(0xFF464848), width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_file,
                      color: Colors.white.withOpacity(0.7), size: 40),
                  const SizedBox(height: 16),
                  Text(
                    model.fileName ?? "Clique para enviar um arquivo",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (model.isLoading) ...[
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(color: Colors.white),
                  ]
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // ------------------------------------
          //      LISTA DE ARQUIVOS ENVIADOS
          // ------------------------------------
          if (model.uploadedFiles.isNotEmpty)
            Column(
              children: [
                ...model.uploadedFiles.map((file) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _uploadedFileTile(file),
                  );
                }),

                const SizedBox(height: 20),

                // ------------------------------------
                //      BOTÃO DE PROCESSAR CANDIDATO
                // ------------------------------------
                SizedBox(
                  width: 240,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: vm.processCandidate, // <-- sua função aqui
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Processar candidato",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _candidateDetail(Candidate candidate) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------------------------------------
          // HEADER
          // -----------------------------------------
          Row(
            children: [
              // FOTO
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  candidate.photoUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 20),

              // NOME + EMAIL
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    candidate.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    candidate.email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // -----------------------------------------
          // DESCRIÇÃO
          // -----------------------------------------
          Text(
            candidate.description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 28),

          // -----------------------------------------
          // NUVEM DE HABILIDADES (KEY SKILLS)
          // -----------------------------------------
          const Text(
            "Habilidades principais",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: candidate.keySkills.map((skill) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  skill,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 32),

          // -----------------------------------------
          // BOTÃO DE CONFIRMAÇÃO / SALVAR
          // -----------------------------------------
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 180,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // vm.confirmCandidate(candidate);
                  // ou o que vc quiser
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Salvar",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _menuTab({
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.white70,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _uploadedFileTile(String fileName) {
    return Container(
      width: 532,
      height: 67,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF101213),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF464848), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ícone + Nome
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                child: Icon(Icons.insert_drive_file,
                    size: 24, color: Colors.white.withOpacity(0.85)),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 280,
                child: Text(
                  fileName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),

          // Botão EXCLUIR
          GestureDetector(
            onTap: () => vm.removeFile(fileName),
            child: Icon(Icons.close,
                color: Colors.white.withOpacity(0.6), size: 22),
          )
        ],
      ),
    );
  }
}
