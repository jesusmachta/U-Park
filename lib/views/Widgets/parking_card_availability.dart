
import 'package:flutter/material.dart';


class ParkingCardAvailability extends StatelessWidget {
  final String name; 
  final int available; 
  final int total; 

  const ParkingCardAvailability({
    Key? key, 
    required this.name, 
    required this.available,
    required this.total,
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    Color availableColor; 
    if (available == 0) {
      availableColor = Colors.grey; // Rojo si no hay disponibles
    } else {
      availableColor = Colors.orange; // Verde si hay más de la mitad
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, -4),
          ),
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        color: Colors.white, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ), 
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16), 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name, 
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black 
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$available',
                    style: TextStyle(
                      fontSize: 48, 
                      fontWeight: FontWeight.bold, 
                      color: availableColor, 
                    ),
                  ),
                  Text(
                    '/$total', 
                    style: const TextStyle(
                      fontSize: 24, 
                      color: Colors.black, 
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



