import 'dart:async';
import 'package:flutter/material.dart';
import 'package:primera_app/controllers/parking_data.dart';
import '/views/Widgets/parking_card_availability.dart'; 

class ParkingAvailabilityWidget extends StatefulWidget {
  const ParkingAvailabilityWidget({Key? key}) : super(key: key);

  @override
  _ParkingAvailabilityWidgetState createState() => _ParkingAvailabilityWidgetState();
}

class _ParkingAvailabilityWidgetState extends State<ParkingAvailabilityWidget> {
  List<ParkingData> parkingData = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Inicializa la carga de datos
    Timer.periodic(Duration(seconds: 30), (timer) {
      fetchData(); // Revisa la base de datos cada 30 segundos
    });
  }

  Future<void> fetchData() async {
    // Simulando la actualización de datos
    setState(() {
      parkingData = [
        ParkingData(name: "Estacionamiento A", available: 15, total: 30),
        ParkingData(name: "Estacionamiento B", available: 5, total: 20),
        ParkingData(name: "Estacionamiento C", available: 0, total: 10),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: parkingData.map((data) {
        return ParkingCardAvailability(
          name: data.name,
          available: data.available,
          total: data.total,
        );
      }).toList(),
    );
  }
}

