import 'package:frontend_central_talentos/views/home/components/dashboard_base_card.dart';
import 'package:frontend_central_talentos/views/home/themes/app_theme.dart';
import 'package:flutter/material.dart';

class MetricChartCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Widget chart;
  final double chartWidth; // permite controlar a largura do gráfico

  const MetricChartCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.chart,
    this.chartWidth = 100,
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
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  if (subtitle != null)
                    Text(subtitle!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                    maxHeight: 100,
                  ),
                  child: chart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
