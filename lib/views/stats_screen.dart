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
      length: 2, // Number of tabs
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
                                    "Estacionamientos",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 231, 229, 229),
                                    ),
                                  ),
                                  Text(
                                    "Estadísticas",
                                    style: TextStyle(
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 241, 239, 239),
                                    ),
                                  )
                                ],
                              ),
                              actions: []),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Tab bar
            const TabBar(
              tabs: [
                Tab(text: "Porcentajes"),
                Tab(text: "Horas Picos"),
              ],
              labelColor: Colors.black,
              indicatorColor: Colors.orange,
            ),
            // Tab bar view
            Expanded(
              child: TabBarView(
                children: [
                  // First tab content
                  SingleChildScrollView(
                    child: ParkingPercentageWidget(),
                  ),
                  // Second tab content
                  SingleChildScrollView(
                    child: PeakHoursWidget(), // Usar el widget de horas pico
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
