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

  final List<String> parkingLotNames = [
    "Plano",
    "Inclinado",
    "VIP",
    "Profesores",
    "Terreno"
  ];

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
          BarChartRodData(
            y: yValue,
            width: 15,
            colors: [
              const Color.fromARGB(255, 255, 164, 27)
            ], 
          ),
        ],
      ));
    }

    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      final size = MediaQuery.of(context).size;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                screenHeight * 0.3,
                0,
                0,
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
                    'Cargando estadísticas...',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text('Error: $errorMessage'));
    }

    return SingleChildScrollView(
      child: Column(
        children: List.generate(5, (index) {
          int parkingLotId = index + 1;
          String parkingLotName = parkingLotNames[index];
          return Column(
            children: [
              Text(
                parkingLotName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 300,
                child: Stack(
                  children: [
                    BarChart(
                      BarChartData(
                        barGroups: getBarChartData(parkingLotId),
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitles: (value) {
                              return value.toInt().toString(); 
                            },
                          ),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitles: (value) {
                              return value.toInt().toString(); 
                            },
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1),
                            left: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 0,
                      child: Text(
                        'Horas',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 5,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'Carros',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
