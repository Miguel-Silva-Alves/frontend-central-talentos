import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/models/candidate.dart';

class AiCandidateCard extends StatelessWidget {
  final Candidate candidate;
  final VoidCallback? onTap;

  const AiCandidateCard({super.key, required this.candidate, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Converte score para porcentagem
    final scorePercent = (candidate.matchScore * 100).toStringAsFixed(1);

    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 650,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF101213),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2A2D31)),
          ),
          child: Stack(
            children: [
              // SCORE NO CANTO SUPERIOR DIREITO
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.greenAccent),
                  ),
                  child: Text(
                    "$scorePercent%",
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // CONTEÚDO DO CARD
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

                  // INFO
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          candidate.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          candidate.email,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          candidate.description,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // SKILLS
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: candidate.keySkills.map((skill) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Text(
                                skill,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
