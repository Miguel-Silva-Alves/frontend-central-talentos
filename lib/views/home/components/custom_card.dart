import 'package:frontend_central_talentos/views/home/components/dashboard_base_card.dart';
import 'package:flutter/material.dart';

class DashboardCustomCard extends StatelessWidget {
  final Widget child;

  const DashboardCustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DashboardCardBase(child: child);
  }
}
