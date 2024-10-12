import 'package:flutter/material.dart';
import 'package:primera_app/views/Widgets/circular_container.dart';
import 'package:primera_app/views/Widgets/curved_edges.dart';
import 'package:primera_app/views/Widgets/custom_appbar.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Feedback",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color:
                                            Color.fromARGB(255, 231, 229, 229),
                                      ),
                                    ),
                                    Text(
                                      "Comentarios",
                                      style: TextStyle(
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 241, 239, 239),
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
                )),
          ],
        )));
  }
}
