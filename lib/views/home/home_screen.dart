import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend_central_talentos/views/components/sidebar/sidebar_component.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_component.dart';
import 'package:frontend_central_talentos/views/components/topbar/topbar_parameter.dart';
import 'package:frontend_central_talentos/views/home/home_model.dart';
import 'package:frontend_central_talentos/views/home/home_vm.dart';
import 'package:frontend_central_talentos/views/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeVm vm;

  @override
  void initState() {
    super.initState();
    vm = HomeVm();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeModel>(
      valueListenable: vm,
      builder: (context, model, _) {
        if (model.goTo != null) {
          final goTo = model.goTo!;
          model.goTo = null;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed(goTo);
          });
        }

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 250, 248, 248),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: TopBarWidget(
              parameter: TopbarParameter(
                onMenuPressed: vm.toggleSidebar,
                goBack: AppRoutes.home,
              ),
            ),
          ),
          body: Row(
            children: [
              if (model.showSidebar)
                const SideBarWidget(selectedItem: "Dashboard"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Cards
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          _buildCard("Online / Total", "12 / 48"),
                          _buildCard("Valores", "832"),
                          _buildCard("Aberturas", "1.245"),
                          _buildCard("Contas Cadastradas", "386"),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Acessos por dia da semana",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 250,
                        child: _buildBarChart(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard(String title, String value) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent)),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final days = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"];
    final values = [42.0, 58.0, 36.0, 79.0, 64.0, 21.0, 45.0];

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final i = value.toInt();
                if (i >= 0 && i < days.length) {
                  return Text(days[i]);
                }
                return const Text('');
              },
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(days.length, (i) {
          return BarChartGroupData(x: i, barRods: [
            BarChartRodData(
              toY: values[i],
              width: 16,
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(6),
            )
          ]);
        }),
      ),
    );
  }
}
