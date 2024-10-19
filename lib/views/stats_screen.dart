import 'package:flutter/material.dart';
import 'package:primera_app/views/Widgets/circular_container.dart';
import 'package:primera_app/views/Widgets/curved_edges.dart';
import 'package:primera_app/views/Widgets/custom_appbar.dart';
import 'package:primera_app/views/Widgets/parking_percentage_widget.dart';
import 'package:primera_app/views/Widgets/peak_hours_widget.dart'; // Importar el widget de horas pico

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de pestañas
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Container(
                color: const Color.fromARGB(255, 253, 111, 45),
                padding: const EdgeInsets.all(0),
                child: const SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                          top: -80, right: -210, child: CircularContainer()),
                      Positioned(
                          top: 40, right: -200, child: CircularContainer()),
                      // Appbar
                      Column(
                        children: [
                          CustomAppbar(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Estadísticas',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            actions: [], // Add an empty list or your desired actions here
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Tabs
            TabBar(
              tabs: [
                Tab(text: 'Porcentaje de Parqueo'),
                Tab(text: 'Horas Pico'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ParkingPercentageWidget(),
                  PeakHoursWidget(), // Usar el widget de horas pico
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
