import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primera_app/models/peak.dart';

class PeakHoursCard extends StatelessWidget {
  final List<Peak> peaks;
  final int parkingLotId;

  PeakHoursCard({required this.peaks, required this.parkingLotId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Estacionamiento $parkingLotId - Horas Pico',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 24, // Horas del día (0-23)
                  barGroups: _createBarGroups(),
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

  List<BarChartGroupData> _createBarGroups() {
    Map<int, int> data = _aggregateData();
    List<BarChartGroupData> barGroups = [];

    data.forEach((hour, count) {
      barGroups.add(
        BarChartGroupData(
          x: hour,
          barRods: [
            BarChartRodData(y: count.toDouble(), colors: [Colors.blue])
          ],
        ),
      );
    });

    return barGroups;
  }

  Map<int, int> _aggregateData() {
    Map<int, int> data = {};

    for (var peak in peaks) {
      int hour = peak.timestamp.hour;
      if (peak.type == 'in') {
        data[hour] = (data[hour] ?? 0) + 1;
      }
    }

    return data;
  }
}
