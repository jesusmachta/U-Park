import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PeakHoursCard extends StatelessWidget {
  final String parkingName;
  final Map<String, int> peakData;

  const PeakHoursCard({
    Key? key,
    required this.parkingName,
    required this.peakData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: peakData.entries.map((entry) {
                    return BarChartGroupData(
                      x: int.parse(entry.key),
                      barRods: [
                        BarChartRodData(
                          y: entry.value.toDouble(),
                          colors: [Colors.blue],
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (double value) {
                        return value.toInt().toString();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
