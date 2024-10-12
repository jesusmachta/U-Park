import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:primera_app/views/Widgets/circular_container.dart';
import 'package:primera_app/views/Widgets/curved_edges.dart';
import 'package:primera_app/views/Widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            // Header
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Puestos de Estacionamiento",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color:
                                            Color.fromARGB(255, 231, 229, 229),
                                      ),
                                    ),
                                    Text(
                                      "Disponibilidad",
                                      style: TextStyle(
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 241, 239, 239),
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          // filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Notificaciones'),
                                              content: const Text(
                                                  'Pronto tendras donde crear notificaciones personalizadas'),
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
                                          color: Color.fromARGB(
                                              206, 255, 255, 255)))
                                ]),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ],
        )));
  }
}
