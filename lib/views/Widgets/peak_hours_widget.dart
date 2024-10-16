import 'package:flutter/material.dart';
import 'package:primera_app/controllers/peak_controller.dart';
import 'package:primera_app/models/peak.dart';
import 'peak_hours_card.dart';

class PeakHoursWidget extends StatefulWidget {
  @override
  State<PeakHoursWidget> createState() => _PeakHoursWidgetState();

  PeakHoursWidget({Key? key}) : super(key: key);
}

class _PeakHoursWidgetState extends State<PeakHoursWidget> {
  late Future<List<Peak>> peakHoursData;

  @override
  void initState() {
    super.initState();
    peakHoursData = PeakController().fetchPeaks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Peak>>(
      future: peakHoursData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No data available');
          return Center(child: Text('No data available'));
        } else {
          print('Data loaded: ${snapshot.data}');
          return PeakHoursCard(peaks: snapshot.data!);
        }
      },
    );
  }
}
