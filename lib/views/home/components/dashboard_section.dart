import 'package:frontend_central_talentos/views/home/components/dashboardtitle_component.dart';
import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final int flex;

  const DashboardSection(
      {super.key, required this.title, required this.children, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardTitle(title: title),
        // Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}
