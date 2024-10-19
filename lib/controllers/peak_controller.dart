import 'package:supabase_flutter/supabase_flutter.dart';

class PeakController {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, int>> getPeakHoursData() async {
    try {
      final response =
          await _supabase.from('peak').select('dayOfWeek').execute();

      if (response.status != 200 || response.data == null) {
        throw Exception('Error fetching peak hours: ${response.status}');
      }

      final data = response.data as List<dynamic>;

      Map<String, int> peakData = {};
      for (var item in data) {
        String day = item['dayOfWeek'];
        if (peakData.containsKey(day)) {
          peakData[day] = peakData[day]! + 1;
        } else {
          peakData[day] = 1;
        }
      }

      return peakData;
    } catch (e) {
      throw Exception('Error fetching peak hours: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getEntries() async {
    try {
      final response = await _supabase.functions.invoke('get-entries');
      if (response.status != 200 || response.data == null) {
        throw Exception('Error fetching entries: ${response.status}');
      }
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception('Error fetching entries: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCars() async {
    try {
      final response = await _supabase.functions.invoke('get-cars');
      if (response.status != 200 || response.data == null) {
        throw Exception('Error fetching cars: ${response.status}');
      }
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception('Error fetching cars: $e');
    }
  }
}
