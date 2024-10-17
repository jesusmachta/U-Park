import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primera_app/models/peak.dart';

class PeakHoursCard extends StatelessWidget {
  final List<Peak> peaks;

  PeakHoursCard({required this.peaks});

  @override
  Widget build(BuildContext context) {
    print('Rendering PeakHoursCard with peaks: $peaks');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Horas Pico',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 12,
                  barGroups: _createBarGroups(),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Mon';
                          case 1:
                            return 'Tue';
                          case 2:
                            return 'Wed';
                          case 3:
                            return 'Thu';
                          case 4:
                            return 'Fri';
                          case 5:
                            return 'Sat';
                          case 6:
                            return 'Sun';
                          default:
                            return '';
                        }
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
    Map<String, List<int>> data = _aggregateData();
    List<BarChartGroupData> barGroups = [];

    data.forEach((day, hours) {
      int index = _dayToIndex(day);
      if (hours.isNotEmpty) {
        barGroups.add(
          BarChartGroupData(
            x: index,
            barRods: hours.map((hour) {
              return BarChartRodData(y: hour.toDouble(), colors: [Colors.blue]);
            }).toList(),
          ),
        );
      } else {
        // Añadir un BarChartRodData vacío para evitar el error
        barGroups.add(
          BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(y: 0, colors: [Colors.transparent])
            ],
          ),
        );
      }
    });

    print('Bar groups created: $barGroups');
    return barGroups;
  }

  Map<String, List<int>> _aggregateData() {
    Map<String, List<int>> data = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
      'Sunday': [],
    };

    for (var peak in peaks) {
      if (data.containsKey(peak.dayOfWeek)) {
        data[peak.dayOfWeek]!.add(peak.timestamp.hour);
      }
    }

    print('Aggregated data: $data');
    return data;
  }

  int _dayToIndex(String day) {
    switch (day) {
      case 'Monday':
        return 0;
      case 'Tuesday':
        return 1;
      case 'Wednesday':
        return 2;
      case 'Thursday':
        return 3;
      case 'Friday':
        return 4;
      case 'Saturday':
        return 5;
      case 'Sunday':
        return 6;
      default:
        return -1;
    }
  }
}
