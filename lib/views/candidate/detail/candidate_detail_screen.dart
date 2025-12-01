import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'candidate_detail_model.dart';
import 'candidate_detail_vm.dart';

class CandidateDetailScreen extends StatefulWidget {
  final Candidate candidate;

  const CandidateDetailScreen({super.key, required this.candidate});

  @override
  State<CandidateDetailScreen> createState() => _CandidateDetailScreenState();
}

class _CandidateDetailScreenState extends State<CandidateDetailScreen> {
  late CandidateDetailVm vm;
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    vm = CandidateDetailVm(widget.candidate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        title: const Text("Detalhes do Candidato"),
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder<CandidateDetailModel>(
        valueListenable: vm,
        builder: (context, model, _) {
          return SingleChildScrollView(
            child: _candidateDetail(model),
          );
        },
      ),
    );
  }

  Widget _candidateDetail(CandidateDetailModel model) {
    final candidate = model.candidate;

    if (descController.text.isEmpty) {
      descController.text = candidate.description;
    }

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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  candidate.photoUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/default_user.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
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
          // DESCRIÇÃO (editável)
          // -----------------------------------------
          Row(
            children: [
              const Text(
                "Descrição",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => vm.toggleEditingDescription(),
                child: const Icon(Icons.edit, color: Colors.white70, size: 18),
              )
            ],
          ),

          const SizedBox(height: 10),

          model.isEditingDescription
              ? Column(
                  children: [
                    TextField(
                      controller: descController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          vm.updateDescription(descController.text);
                          vm.toggleEditingDescription();
                        },
                        child: const Text("Salvar Descrição"),
                      ),
                    ),
                  ],
                )
              : Text(
                  candidate.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

          const SizedBox(height: 28),
          _buildEditableField(
            label: "Data de nascimento",
            isEditing: model.isEditingBirthDate,
            onEditTap: vm.toggleEditingBirthDate,
            controller: model.birthDateCtrl,
            displayValue: widget.candidate.birthDate ?? "---",
          ),
          _buildEditableField(
            label: "Telefone",
            isEditing: model.isEditingPhone,
            onEditTap: vm.toggleEditingPhone,
            controller: model.phoneCtrl,
            displayValue: widget.candidate.phone ?? "---",
          ),
          _buildEditableField(
            label: "Anos de experiência",
            isEditing: model.isEditingYearsExperience,
            onEditTap: vm.toggleEditingYearsExperience,
            controller: model.yearsExperienceCtrl,
            displayValue: widget.candidate.yearsExperience?.toString() ?? "---",
          ),
          _buildEditableField(
            label: "Localização",
            isEditing: model.isEditingLocation,
            onEditTap: vm.toggleEditingLocation,
            controller: model.locationCtrl,
            displayValue: widget.candidate.location ?? "---",
          ),
          _buildEditableField(
            label: "Cargo atual",
            isEditing: model.isEditingCurrentPosition,
            onEditTap: vm.toggleEditingCurrentPosition,
            controller: model.currentPositionCtrl,
            displayValue: widget.candidate.currentPosition ?? "---",
          ),

          // -----------------------------------------
          // HABILIDADES PRINCIPAIS
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      skill,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => vm.removeSkill(skill),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white54,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 32),

          _buildFilesSection(candidate),

          const SizedBox(height: 32),

          // -----------------------------------------
          // BOTÃO SALVAR GERAL
          // -----------------------------------------
          SizedBox(
            width: 180,
            height: 48,
            child: ElevatedButton(
              onPressed: model.isSaving ? null : vm.saveCandidate,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    model.saved ? Colors.green : const Color(0xFF4CAF50),
              ),
              child: model.isSaving
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(model.saved ? "Salvo ✓" : "Salvar"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilesSection(Candidate candidate) {
    final files = candidate.filesUploaded ?? [];

    if (files.isEmpty) {
      return const Text(
        "Nenhum arquivo enviado",
        style: TextStyle(color: Colors.white70),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Arquivos enviados",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...files.map((file) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 📝 Nome + Tamanho
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        file["name"] ?? "Sem nome",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${file["size_mb"]?.toStringAsFixed(2)} MB",
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // ⬇ Botão de download
                GestureDetector(
                  onTap: () async {
                    final url = file["download_url"];
                    if (url != null) {
                      await _downloadFile(url, file["name"]);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.download, size: 18, color: Colors.white),
                        SizedBox(width: 4),
                        Text("Baixar", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Future<void> _downloadFile(String url, String fileName) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Erro ao abrir $url");
    }
  }

  Widget _buildEditableField({
    required String label,
    required bool isEditing,
    required VoidCallback onEditTap,
    required TextEditingController controller,
    required String displayValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: onEditTap,
              child: const Icon(Icons.edit, color: Colors.white70, size: 18),
            )
          ],
        ),
        const SizedBox(height: 10),
        isEditing
            ? TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(),
                ),
              )
            : Text(
                displayValue,
                style: const TextStyle(color: Colors.white70),
              ),
        const SizedBox(height: 20),
      ],
    );
  }
}
