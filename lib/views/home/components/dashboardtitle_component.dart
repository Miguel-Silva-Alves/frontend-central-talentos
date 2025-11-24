import 'package:frontend_central_talentos/views/home/themes/app_theme.dart';
import 'package:flutter/material.dart';

class DashboardTitle extends StatelessWidget {
  final String title;

  const DashboardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.cardPadding,
      margin: const EdgeInsets.only(top: 16, bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppTheme.cardTitleFontSize,
          fontWeight: FontWeight.bold,
          color: AppTheme.titleColor,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
