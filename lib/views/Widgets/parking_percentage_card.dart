import 'package:flutter/material.dart';

class ParkingPercentageCard extends StatelessWidget {
  final String parkingName;
  final String percentage;

  const ParkingPercentageCard({
    Key? key,
    required this.parkingName,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color availableColor;
    if (double.parse(percentage) > 50) {
      availableColor = Colors.green;
    } else if (double.parse(percentage) > 20) {
      availableColor = Colors.orange;
    } else {
      availableColor = Colors.red;
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parkingName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '$percentage%',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: availableColor,
            ),
          ),
          const SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: double.parse(percentage) / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(availableColor),
          ),
        ],
      ),
    );
  }
}
