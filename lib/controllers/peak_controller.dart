import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:primera_app/models/peak.dart';

class PeakController {
  final SupabaseClient _supabase = Supabase.instance.client;

  PeakController() {
    _supabase.from('peak').stream(primaryKey: ['id']).listen((event) {
      for (final record in event) {
        fetchParkingStats(record as String);
      }
    });
  }

  Future<void> _createDailyGraph(List<Peak> peaks) async {
    // Agrupar los picos por día de la semana
    Map<String, int> dailyCounts = {
      'Monday': 0,
      'Tuesday': 0,
      'Wednesday': 0,
      'Thursday': 0,
      'Friday': 0,
      'Saturday': 0,
      'Sunday': 0,
    };

    for (var peak in peaks) {
      if (dailyCounts.containsKey(peak.dayOfWeek)) {
        dailyCounts[peak.dayOfWeek] = dailyCounts[peak.dayOfWeek]! + 1;
      }
    }

    // Aquí puedes agregar la lógica para crear la gráfica diaria
    // Por ejemplo, podrías usar una biblioteca de gráficos para generar la gráfica
    print('Daily counts: $dailyCounts');
  }

  Future<List<Peak>> fetchParkingStats(String parkingLotId) async {
    final response = await _supabase
        .from('peak')
        .select()
        .eq('id', parkingLotId)
        .gte('timestamp',
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String())
        .execute();

    if (response.status != 200) {
      throw Exception('Failed to fetch data');
    }

    final data = response.data as List<dynamic>;
    return transformParkingStats(data);
  }

  Future<List<Peak>> fetchPeaks() async {
    final response = await _supabase
        .from('peak')
        .select()
        .gte('timestamp',
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String())
        .execute();

    if (response.status != 200) {
      throw Exception('Failed to fetch data');
    }

    final data = response.data as List<dynamic>;
    print('Fetched peaks: $data');
    return transformParkingStats(data);
  }

  List<Peak> transformParkingStats(List data) {
    return data
        .map((item) => Peak(
              id: item['id'].toString(),
              timestamp: DateTime.parse(item['timestamp']),
              dayOfWeek: item['dayOfWeek'].toString(),
              type: item['type'].toString(),
              idParkingLot: item['idParkingLot'].toString(),
            ))
        .toList();
  }
}
