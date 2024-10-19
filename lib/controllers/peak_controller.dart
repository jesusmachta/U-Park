import 'package:supabase/supabase.dart';

class PeakController {
  final SupabaseClient supabaseClient;

  PeakController(this.supabaseClient);

  Future<Map<int, Map<int, int>>> fetchPeakHours() async {
    final response = await supabaseClient.from('entries').select().execute();

    print("Response from Supabase: ${response.data}");

    if (response.status == 200) {
      if (response.data is List) {
        return processEntries(response.data);
      } else {
        print("No data returned from Supabase.");
        return {};
      }
    } else {
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

      if (parkingLotId < 1 || parkingLotId > 5) continue;

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
