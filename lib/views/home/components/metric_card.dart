import 'package:frontend_central_talentos/views/home/components/dashboard_base_card.dart';
import 'package:frontend_central_talentos/views/home/themes/app_theme.dart';
import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppTheme.cardTitleFontSize,
              fontWeight: FontWeight.bold,
              color: AppTheme.titleColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: AppTheme.cardValueFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(subtitle!,
                  style: const TextStyle(
                      fontSize: AppTheme.cardSubtitleFontSize,
                      color: AppTheme.subtitleColor)),
            ),
        ],
      ),
    );
  }
}
