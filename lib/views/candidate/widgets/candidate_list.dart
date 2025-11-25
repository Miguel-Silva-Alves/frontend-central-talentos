import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';
import 'package:frontend_central_talentos/views/candidate/upload_vm.dart';

class CandidateListWidget extends StatelessWidget {
  final List<Candidate> candidates;
  final UploadVm vm;

  const CandidateListWidget({
    super.key,
    required this.candidates,
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    if (candidates.isEmpty) {
      return const Center(
        child: Text("Nenhum candidato encontrado",
            style: TextStyle(color: Colors.white70)),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: candidates.map((c) {
        return GestureDetector(
          onTap: () => vm.openCandidate(c),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF101213),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF464848)),
            ),
            child: Row(
              children: [
                // Foto
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    c.photoUrl,
                    width: 50,
                    height: 50,
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

                const SizedBox(width: 16),

                // Nome + email + descrição
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        c.email,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        c.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6), fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
