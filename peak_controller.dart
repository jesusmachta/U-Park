import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
//import 'package:primera_app/models/peak.dart';


class Peak {
  int hour;
  int currentCars;

  Peak({
    required this.hour,
    required this.currentCars,
  });

  factory Peak.fromMap(Map<String, dynamic> map) {
    return Peak(
      hour: map['hour'],
      currentCars: map['currentCars'],
    );
  }
}

class PeakController {
  final SupabaseClient supabaseClient;

  PeakController(this.supabaseClient);

  Future<List<Peak>> fetchPeakFromApi(int parkingLot, String date) async {
    final response = await supabaseClient.functions.invoke(
      'get-cars',
      method: HttpMethod.get,
      queryParameters: {'parkingLot': parkingLot.toString(), 'date': date},
      headers: {
        'Authorization': 'Bearer ${supabaseClient.auth.currentSession?.accessToken}'
      },
    );

    if (response.data != null) {
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      final List<dynamic> results = data['results'];
      return results.map((json) => Peak.fromMap(json)).toList();
    } else {
      print("Error fetching peak data: $response");
      throw Exception('Error fetching peak data');
    }
  }
}

