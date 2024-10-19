import 'package:flutter/material.dart';

// class ParkingPercentageCard extends StatelessWidget {
//   final String parkingName;
//   final String percentage;

//   const ParkingPercentageCard({
//     Key? key,
//     required this.parkingName,
//     required this.percentage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     Color availableColor;
//     if (double.parse(percentage) > 50) {
//       availableColor = Colors.green;
//     } else if (double.parse(percentage) > 20) {
//       availableColor = Colors.orange;
//     } else {
//       availableColor = Colors.red;
//     }
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       margin:
//           EdgeInsets.symmetric(vertical: 8.0, horizontal: screenWidth * 0.02),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             parkingName,
//             style: const TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             '$percentage%',
//             style: TextStyle(
//               fontSize: 24.0,
//               fontWeight: FontWeight.bold,
//               color: availableColor,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           LinearProgressIndicator(
//             value: double.parse(percentage) / 100,
//             backgroundColor: Colors.grey[300],
//             valueColor: AlwaysStoppedAnimation<Color>(availableColor),
//           ),
//         ],
//       ),
//     );
//   }
// }

// clase donde se calcula el porcentaje dado la instancia de parking lot 
class ParkingPercentageCard extends StatelessWidget {
  final String parkingName;
  final int currentCars;
  final int totalSpots;

  const ParkingPercentageCard({
    super.key,
    required this.parkingName,
    required this.currentCars,
    required this.totalSpots,
  });

  // Método para calcular el porcentaje
  double calculatePercentage() {
      int validCars = currentCars > totalSpots ? totalSpots : currentCars; // Validar que los carros no superen los puestos
    if (totalSpots == 0) return 0; // Evitar división por cero
    return (validCars / totalSpots) * 100;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double percentage = calculatePercentage(); // Calcular el porcentaje
    Color availableColor;

    // Determinar el color según el porcentaje
    if (percentage > 50) {
      availableColor = Colors.green;
    } else if (percentage > 20) {
      availableColor = Colors.orange;
    } else {
      availableColor = Colors.red;
    }

    return Container(
      key: ValueKey(parkingName),
      padding: const EdgeInsets.all(16.0),
      margin:
          EdgeInsets.symmetric(vertical: 8.0, horizontal: screenWidth * 0.02),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parkingName.toUpperCase(),
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '${percentage.toStringAsFixed(2)}%', // Mostrar porcentaje con 2 decimales
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: availableColor,
            ),
          ),
          const SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(availableColor),
          ),
        ],
      ),
    );
  }
}