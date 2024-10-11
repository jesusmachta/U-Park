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
                  color: const Color.fromARGB(1, 1, 1, 1),
                  padding: const EdgeInsets.all(0),
                  child: const SizedBox(
                    height: 400,
                    child: Stack(
                      children: [
                        Positioned(
                            top: -150, right: -250, child: CircularContainer()),
                        Positioned(
                            top: 180, right: -300, child: CircularContainer()),
                      ],
                    ),
                  ),
                ))
          ],
        )));
  }
}
