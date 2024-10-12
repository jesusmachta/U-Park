import 'package:flutter/material.dart';
import 'dart:async';
import 'parking_percentage_card.dart';

class ParkingPercentageWidget extends StatefulWidget {
  const ParkingPercentageWidget({Key? key}) : super(key: key);

  @override
  State<ParkingPercentageWidget> createState() =>
      _ParkingPercentageWidgetState();
}

class ParkingData {
  final String parkingName;
  final double percentage;

  ParkingData({required this.parkingName, required this.percentage});
}

class _ParkingPercentageWidgetState extends State<ParkingPercentageWidget> {
  List<ParkingData> parkingData = [];

  @override
  void initState() {
    super.initState();
    fetchParkingData();
    Timer.periodic(Duration(seconds: 30), (timer) {
      fetchParkingData();
    });
  }

  Future<void> fetchParkingData() async {
    setState(() {
      parkingData = [
        ParkingData(
          parkingName: "Plano",
          percentage: 80.0,
        ),
        ParkingData(
          parkingName: "Inclinado",
          percentage: 60.0,
        ),
        ParkingData(
          parkingName: "4x4",
          percentage: 40.0,
        ),
        ParkingData(
          parkingName: "VIP",
          percentage: 20.0,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: parkingData.map((data) {
        return ParkingPercentageCard(
          parkingName: data.parkingName,
          percentage: data.percentage
              .toStringAsFixed(1), // Convert to string with one decimal place
        );
      }).toList(),
    );
  }
}
