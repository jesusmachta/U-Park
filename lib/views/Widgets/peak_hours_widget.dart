import 'package:flutter/material.dart';
import 'package:primera_app/controllers/peak_controller.dart';
import 'peak_hours_card.dart';

class PeakHoursWidget extends StatefulWidget {
  const PeakHoursWidget({Key? key}) : super(key: key);

  @override
  _PeakHoursWidgetState createState() => _PeakHoursWidgetState();
}

class _PeakHoursWidgetState extends State<PeakHoursWidget> {
  final PeakController _controller = PeakController();
  late Future<List<Map<String, dynamic>>> _entriesFuture;
  late Future<List<Map<String, dynamic>>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _entriesFuture = _controller.getEntries();
    _carsFuture = _controller.getCars();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait<dynamic>([_entriesFuture, _carsFuture]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final entries = snapshot.data![0];
        final cars = snapshot.data![1];

        // Verifica que entries tenga datos
        if (entries.isEmpty) {
          return const Center(child: Text('No entries available'));
        }

        Map<String, Map<String, int>> peakDataByParking = {};

        for (var entry in entries) {
          final parkingName = entry['parkingName'];
          final hour = entry['hour'];

          // Asegúrate de que parkingName y hour sean válidos
          if (parkingName != null && hour != null) {
            peakDataByParking.putIfAbsent(parkingName, () => {});
            peakDataByParking[parkingName]![hour] =
                (peakDataByParking[parkingName]![hour] ?? 0) + 1;
          }
        }

        return ListView(
          children: peakDataByParking.entries.map((entry) {
            return PeakHoursCard(
              parkingName: entry.key,
              peakData: entry.value,
            );
          }).toList(),
        );
      },
    );
  }
}
