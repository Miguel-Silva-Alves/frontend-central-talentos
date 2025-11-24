import 'package:frontend_central_talentos/views/home/components/dashboard_section.dart';
import 'package:frontend_central_talentos/views/home/themes/app_theme.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatelessWidget {
  final List<DashboardSection> sections;

  const DashboardLayout({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 720;

        if (isMobile) {
          return SingleChildScrollView(
            padding: AppTheme.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: sections,
            ),
          );
        }

        return SingleChildScrollView(
            child: Padding(
          padding: AppTheme.screenPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sections.map((section) {
              return Expanded(
                  flex: section.flex,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: section,
                  ));
            }).toList(),
          ),
        ));

/*         return Padding(
          padding: AppTheme.screenPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sections.map((section) {
              return Expanded(flex: section.flex, child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: section,
              ));
            }).toList(),
          ),
        ); */
      },
    );
  }
}
