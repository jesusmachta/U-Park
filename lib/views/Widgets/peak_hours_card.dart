import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primera_app/controllers/peak_controller.dart';

class PeakHoursCard extends StatefulWidget {
  final PeakController peakController;

  PeakHoursCard({required this.peakController});

  @override
  _PeakHoursCardState createState() => _PeakHoursCardState();
}

class _PeakHoursCardState extends State<PeakHoursCard> {
  Map<int, Map<int, int>> peakHours = {};

  @override
  void initState() {
    super.initState();
    fetchPeakHours();
  }

  Future<void> fetchPeakHours() async {
    try {
      final hours = await widget.peakController.fetchPeakHours();
      setState(() {
        peakHours = hours;
      });
    } catch (e) {
      print('Error fetching peak hours: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return peakHours.isEmpty
        ? Center(child: CircularProgressIndicator())
        : BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: peakHours.entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                        y: entry.value.values
                            .reduce((a, b) => a + b)
                            .toDouble(),
                        colors: [Colors.blue])
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
          );
  }
}
