import 'package:flutter/material.dart';
import 'package:primera_app/controllers/parking_lot_controller.dart';
import 'package:primera_app/models/parking_lot.dart';
import '/views/Widgets/parking_card_availability.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<List<ParkingLot>>(
      stream: controller.getParkingLots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          final size = MediaQuery.of(context).size;

          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0, // Izquierda
                    screenHeight * 0.3, // Arriba
                    0, // Derecha
                    0, // Abajo
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: size.width * 0.02,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.orangeAccent),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Cargando estacionamientos...',
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ]));
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final parkingLots = snapshot.data ?? [];

        return Column(
          children: parkingLots.map((parkingLot) {
            // Validaciones de Cantidad de Carros
            final cars = parkingLot.cars;
            final space = parkingLot.totalParkingSpace;
            var available = space - cars;
            if (cars > space) {
              available = 0;
            }

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
