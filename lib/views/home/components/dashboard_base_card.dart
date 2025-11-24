import 'package:frontend_central_talentos/views/home/themes/app_theme.dart';
import 'package:flutter/material.dart';

class DashboardCardBase extends StatelessWidget {
  final Widget child;

  const DashboardCardBase({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.cardPadding,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: child,
    );
  }
}
