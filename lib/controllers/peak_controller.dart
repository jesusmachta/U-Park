import 'package:supabase/supabase.dart';

class PeakController {
  final SupabaseClient supabaseClient;

  PeakController(this.supabaseClient);

  Future<Map<int, Map<int, int>>> fetchPeakHours() async {
    final response = await supabaseClient.from('entries').select().execute();

    // Imprimimos la respuesta cruda para ver qué estamos recibiendo
    print("Response from Supabase: ${response.data}");

    // Verificamos el estado de la respuesta
    if (response.status == 200) {
      if (response.data is List) {
        return processEntries(response.data);
      } else {
        print("No data returned from Supabase.");
        return {}; // Retornamos un mapa vacío si no hay datos
      }
    } else {
      // Imprimir el mensaje de error si la consulta no se ejecuta correctamente
      print("Error fetching entries: ${response.status}");
      throw Exception('Error fetching entries');
    }
  }

  Map<int, Map<int, int>> processEntries(List<dynamic> entries) {
    Map<int, Map<int, int>> hoursCount = {};

    for (var entry in entries) {
      DateTime timeOfEntry = DateTime.parse(entry['timeOfEntry']);
      int hour = timeOfEntry.hour;
      int parkingLotId = entry['parkingLotId'];

      // Asegúrate de que parkingLotId esté entre 1 y 4
      if (parkingLotId < 1 || parkingLotId > 4) continue;

      if (!hoursCount.containsKey(parkingLotId)) {
        hoursCount[parkingLotId] = {};
      }

      if (hoursCount[parkingLotId]!.containsKey(hour)) {
        hoursCount[parkingLotId]![hour] = hoursCount[parkingLotId]![hour]! + 1;
      } else {
        hoursCount[parkingLotId]![hour] = 1;
      }
    }

    return hoursCount;
  }
}
