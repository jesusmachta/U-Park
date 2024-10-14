import 'package:flutter/material.dart';
import 'package:primera_app/controllers/parking_lot_controller.dart';
import 'package:primera_app/models/parking_lot.dart';
import 'dart:async';
import 'parking_percentage_card.dart';

// class ParkingPercentageWidget extends StatefulWidget {
//   const ParkingPercentageWidget({Key? key}) : super(key: key);

//   @override
//   State<ParkingPercentageWidget> createState() =>
//       _ParkingPercentageWidgetState();
// }

// class ParkingData {
//   final String parkingName;
//   final double percentage;

//   ParkingData({required this.parkingName, required this.percentage});
// }

// class _ParkingPercentageWidgetState extends State<ParkingPercentageWidget> {
//   List<ParkingData> parkingData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchParkingData();
//     Timer.periodic(Duration(seconds: 30), (timer) {
//       fetchParkingData();
//     });
//   }

//   Future<void> fetchParkingData() async {
//     setState(() {
//       parkingData = [
//         ParkingData(
//           parkingName: "Plano",
//           percentage: 80.0,
//         ),
//         ParkingData(
//           parkingName: "Inclinado",
//           percentage: 60.0,
//         ),
//         ParkingData(
//           parkingName: "4x4",
//           percentage: 40.0,
//         ),
//         ParkingData(
//           parkingName: "VIP",
//           percentage: 20.0,
//         ),
//       ];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: parkingData.map((data) {
//         return ParkingPercentageCard(
//           parkingName: data.parkingName,
//           percentage: data.percentage
//               .toStringAsFixed(1), // Convert to string with one decimal place
//         );
//       }).toList(),
//     );
//   }
// }



import 'package:primera_app/controllers/parking_lot_controller.dart'; // Importar tu controlador

class ParkingPercentageWidget extends StatefulWidget {
  const ParkingPercentageWidget({Key? key}) : super(key: key);

  @override
  State<ParkingPercentageWidget> createState() =>
      _ParkingPercentageWidgetState();
}

class _ParkingPercentageWidgetState extends State<ParkingPercentageWidget> {
  final ParkingLotController _controller = ParkingLotController();
  List<ParkingLot> parkingLots = [];

  @override
  void initState() {
    super.initState();
    _listenToParkingData(); // Iniciar la escucha del stream
  }

  // Método para escuchar los datos en tiempo real
  void _listenToParkingData() {
    _controller.getParkingLots().listen((lots) {
      setState(() {
        parkingLots = lots; // Actualizar la lista de estacionamientos
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: parkingLots.map((lot) {
        return ParkingPercentageCard(
          key: ValueKey(lot.id), // Asignar una clave única basada en el ID
          parkingName: lot.name,
          currentCars: lot.cars,
          totalSpots: lot.totalParkingSpace,
        );
      }).toList(),
    );
  }
}
