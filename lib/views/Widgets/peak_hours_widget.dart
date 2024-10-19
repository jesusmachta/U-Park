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
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlibHphdXFqeGdtZWpqdWtwbGl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0MTY5MjUsImV4cCI6MjA0Mzk5MjkyNX0.09RA0WlPdtmVm7f7O-so8omxQx4ppOLtZgtxCiAoLDw'); // Cambia esto por tu clave

  Map<int, Map<int, int>> peakHours = {};
  bool isLoading = true; // Estado de carga
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchEntries();
  }

  Future<void> fetchEntries() async {
    setState(() {
      isLoading = true; // Activar estado de carga
      errorMessage = ''; // Reiniciar mensaje de error
    });

    try {
      PeakController peakController = PeakController(supabaseClient);
      peakHours = await peakController.fetchPeakHours();
    } catch (e) {
      setState(() {
        errorMessage = e.toString(); // Guardar el mensaje de error
      });
    } finally {
      setState(() {
        isLoading = false; // Desactivar estado de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator()); // Cargando
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text('Error: $errorMessage')); // Mostrar error
    }

    // Aquí puedes construir tu gráfico
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: peakHours.entries.expand((entry) {
          return entry.value.entries.map((hourEntry) {
            return BarChartGroupData(
              x: entry.key, // Estacionamiento
              barRods: [
                BarChartRodData(
                    y: hourEntry.value.toDouble(), colors: [Colors.blue]),
              ],
            );
          });
        }).toList(),
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              return 'Estacionamiento ${value.toInt()}'; // Mostrar estacionamientos
            },
          ),
        ),
      ),
    );
  }
}
