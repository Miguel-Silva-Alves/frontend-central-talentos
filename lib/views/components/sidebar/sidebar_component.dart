import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';

class SideBarWidget extends StatelessWidget {
  final String selectedItem;
  const SideBarWidget({super.key, required this.selectedItem});

  // Novo tipo: cada item pode ter subitems e ser não clicável
  Map<String, dynamic> get sidebarItems => {
        'Dashboard': {
          'icon': Icons.dashboard,
          'goTo': AppRoutes.home,
        },
        'Candidatos': {
          'icon': Icons.emoji_people,
          'goTo': AppRoutes.candidateInput,
        },
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFF1E1E1E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ...sidebarItems.entries.expand((entry) {
            final String title = entry.key;
            final Map<String, dynamic> value = entry.value;

            final bool clickable = value['clickable'] != false;
            final Map<String, dynamic>? subItems = value['subItems'];

            final List<Widget> widgets = [];

            // Item principal
            widgets.add(
              ListTile(
                leading: Icon(value['icon'],
                    color: title == selectedItem
                        ? const Color.fromARGB(255, 238, 255, 0)
                        : Colors.white),
                title: Text(
                  title,
                  style: TextStyle(
                    color: title == selectedItem
                        ? const Color.fromARGB(255, 238, 255, 0)
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: clickable
                    ? () {
                        Navigator.pushNamed(context, value['goTo']);
                      }
                    : null,
              ),
            );

            // Subitens (se existirem)
            if (subItems != null) {
              widgets.addAll(subItems.entries.map((subEntry) {
                final String subTitle = subEntry.key;
                final Map<String, dynamic> subValue = subEntry.value;
                final bool clickableSub = subValue['clickable'] != false;

                return Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: ListTile(
                    leading: Icon(
                      subValue['icon'],
                      size: 20,
                      color: subTitle == selectedItem
                          ? const Color.fromARGB(255, 238, 255, 0)
                          : Colors.white70,
                    ),
                    title: Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: subTitle == selectedItem
                            ? const Color.fromARGB(255, 238, 255, 0)
                            : Colors.white70,
                      ),
                    ),
                    onTap: clickableSub
                        ? () {
                            Navigator.pushNamed(context, subValue['goTo']);
                          }
                        : null,
                  ),
                );
              }));
            }

            return widgets;
          }),
        ],
      ),
    );
  }
}
