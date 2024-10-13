import 'package:primera_app/models/parking_lot.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ParkingLotController {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<ParkingLot>> getParkingLots() {
    final plStream = _supabase.from('parkingLot').stream(primaryKey: ['id']);
    return plStream.map((maps) => maps
        .map((map) => ParkingLot(
            id: map['id'],
            name: map['name'],
            location: map['location'],
            totalParkingSpace: map['totalParkingSpace'],
            cars: map['cars']))
        .toList());
  }
}
