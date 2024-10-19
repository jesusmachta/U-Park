import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:primera_app/controllers/parking_lot_controller.dart';
import 'package:primera_app/views/Widgets/circular_container.dart';
import 'package:primera_app/views/Widgets/curved_edges.dart';
import 'package:primera_app/views/Widgets/custom_appbar.dart';
import 'package:primera_app/views/Widgets/parking_availability_widget.dart';
// ignore: unused_import
import 'package:primera_app/views/Widgets/parking_card_availability.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ParkingLotController controller = ParkingLotController();
  // Dentro del body del widget debes tener un StreamBuilder para que se actualice según los datos recibidos en tiempo real
  // Este StreamBuilder debe tener la siguiente variable del controlador para obtener los datos
  // stream: controller.getParkingLots(),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // Se cambia a `Column` para manejar la estructura principal
        children: [
          // Header (Encabezado fijo, no hace scroll)
          ClipPath(
            clipper: CustomCurvedEdges(),
            child: Container(
              color: const Color.fromARGB(255, 253, 111, 45),
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    const Positioned(
                        top: -80, right: -210, child: CircularContainer()),
                    const Positioned(
                        top: 40, right: -200, child: CircularContainer()),
                    // Appbar
                    Column(
                      children: [
                        CustomAppbar(
                          title: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Puestos de Estacionamiento",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(255, 231, 229, 229),
                                ),
                              ),
                              Text(
                                "Disponibilidad",
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 241, 239, 239),
                                ),
                              )
                            ],
                          ),
                          actions: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Notificaciones'),
                                      content: const Text(
                                          'Pronto tendrás donde crear notificaciones personalizadas'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cerrar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Iconsax.notification,
                                  color: Color.fromARGB(206, 255, 255, 255)),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          // Parte dinámica con scroll
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ParkingAvailabilityWidget(), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
