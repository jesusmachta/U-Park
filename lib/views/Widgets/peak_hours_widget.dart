import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primera_app/controllers/peak_controller.dart';
import 'package:supabase/supabase.dart';

class PeakHoursWidget extends StatefulWidget {
  @override
  _PeakHoursWidgetState createState() => _PeakHoursWidgetState();
}

class _PeakHoursWidgetState extends State<PeakHoursWidget> {
  final SupabaseClient supabaseClient = SupabaseClient(
      'https://yblzauqjxgmejjukplix.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlibHphdXFqeGdtZWpqdWtwbGl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0MTY5MjUsImV4cCI6MjA0Mzk5MjkyNX0.09RA0WlPdtmVm7f7O-so8omxQx4ppOLtZgtxCiAoLDw');

  Map<int, Map<int, int>> peakHours = {};
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchEntries();
  }

  Future<void> fetchEntries() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      PeakController peakController = PeakController(supabaseClient);
      peakHours = await peakController.fetchPeakHours();
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<BarChartGroupData> getBarChartData(int parkingLotId) {
    List<BarChartGroupData> barGroups = [];
    Map<int, int> hourData = peakHours[parkingLotId]!;

    for (var hour = 6; hour <= 19; hour++) {
      double yValue = hourData[hour]?.toDouble() ?? 0.0;
      barGroups.add(BarChartGroupData(
        x: hour,
        barRods: [
          BarChartRodData(y: yValue, width: 15, colors: [Colors.blue])
        ],
      ));
    }

    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text('Error: $errorMessage'));
    }

    return SingleChildScrollView(
      child: Column(
        children: List.generate(5, (index) {
          int parkingLotId = index + 1;
          return Column(
            children: [
              Text(
                'Estacionamiento $parkingLotId',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 300, // Aumentar la altura para acomodar las etiquetas
                child: BarChart(
                  BarChartData(
                    barGroups: getBarChartData(parkingLotId),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(showTitles: true),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTitles: (value) {
                          return value.toInt().toString(); // Mostrar horas
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
