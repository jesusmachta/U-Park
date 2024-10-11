import 'package:flutter/material.dart';
import 'package:primera_app/views/Widgets/circular_container.dart';
import 'package:primera_app/views/Widgets/curved_edges.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            ClipPath(
                clipper: CustomCurvedEdges(),
                child: Container(
                  color: const Color.fromARGB(255, 253, 111, 45),
                  padding: const EdgeInsets.all(0),
                  child: const SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        Positioned(
                            top: -120, right: -210, child: CircularContainer()),
                        Positioned(
                            top: 40, right: -200, child: CircularContainer()),
                      ],
                    ),
                  ),
                ))
          ],
        )));
  }
}
