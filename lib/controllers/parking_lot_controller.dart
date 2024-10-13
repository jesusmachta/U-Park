import 'package:primera_app/models/parking_lot.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ParkingLotController {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<ParkingLot>> getParkingLots() {
    final plStream = _supabase.from('parkingLot').stream(primaryKey: ['id']);
    return plStream.map((maps) => maps
        .map((map) => ParkingLot(
            id: map['id'].toString(),
            name: map['name'].toString(),
            location: map['location'].toString(),
            totalParkingSpace: map['totalParkingSpace'] as int,
            cars: map['cars'] as int))
        .toList());
  }
}
