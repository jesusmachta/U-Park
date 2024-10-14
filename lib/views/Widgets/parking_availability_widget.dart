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
    return StreamBuilder<List<ParkingLot>>(
      stream: controller.getParkingLots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          final size = MediaQuery.of(context).size;

          return Center(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                CircularProgressIndicator(
                  strokeWidth: size.width * 0.02, 
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                ),
              SizedBox(height: size.height * 0.02), 
              Text(
                'Cargando estacionamientos...',
                style: TextStyle(
                fontSize: size.width * 0.05, 
                fontWeight: FontWeight.w500,
                ),
              ),
              ],
            ),
          );
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
