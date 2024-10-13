import 'dart:async';
import 'package:flutter/material.dart';
import 'package:primera_app/controllers/parking_data.dart';
import 'package:primera_app/controllers/parking_lot_controller.dart';
import 'package:primera_app/models/parking_lot.dart';
import '/views/Widgets/parking_card_availability.dart';

// class ParkingAvailabilityWidget extends StatefulWidget {
//   const ParkingAvailabilityWidget({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ParkingAvailabilityWidgetState createState() =>
//       _ParkingAvailabilityWidgetState();
// }

// class _ParkingAvailabilityWidgetState extends State<ParkingAvailabilityWidget> {
//   List<ParkingData> parkingData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Inicializa la carga de datos
//     Timer.periodic(const Duration(seconds: 30), (timer) {
//       fetchData(); // Revisa la base de datos cada 30 segundos
//     });
//   }

//   Future<void> fetchData() async {
//     // Simulando la actualización de datos
//     setState(() {
//       parkingData = [
//         ParkingData(name: "Estacionamiento A", available: 15, total: 30),
//         ParkingData(name: "Estacionamiento B", available: 5, total: 20),
//         ParkingData(name: "Estacionamiento C", available: 0, total: 10),
//       ];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: parkingData.map((data) {
//         return ParkingCardAvailability(
//           name: data.name,
//           available: data.available,
//           total: data.total,
//         );
//       }).toList(),
//     );
//   }
// }

class ParkingAvailabilityWidget extends StatefulWidget {
  const ParkingAvailabilityWidget({super.key});

  @override
  _ParkingAvailabilityWidgetState createState() =>
      _ParkingAvailabilityWidgetState();
}

class _ParkingAvailabilityWidgetState extends State<ParkingAvailabilityWidget> {
  final ParkingLotController controller = ParkingLotController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ParkingLot>>(
      stream: controller.getParkingLots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Cargando datos
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final parkingLots = snapshot.data ?? [];

        return Column(
          children: parkingLots.map((parkingLot) {
            final available = parkingLot.totalParkingSpace - parkingLot.cars;

            return ParkingCardAvailability(
              name: parkingLot.name,
              available: available,
              total: parkingLot.totalParkingSpace,
            );
          }).toList(),
        );
      },
    );
  }
}
