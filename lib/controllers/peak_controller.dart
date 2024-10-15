// ignore: unused_import
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore: unused_import
import 'package:cron/cron.dart';
import 'package:primera_app/models/peak.dart';

class ParkingLotController {
  final SupabaseClient _supabase = Supabase.instance.client;
  //final _cron = Cron();
  //Map<String, bool> _canCreatePeakHourRecord = {};

  ParkingLotController() {
    List<Peak> peaks = fetchPeaks() as List<Peak>;
    _createDailyGraph(peaks);
    //Inicializar el mapa booleano
    //_initializeCanCreatePeakHourRecord();

    // Escucha cambios en la tabla de estacionamientos originalmente
    // Ahora es en peak
    _supabase.from('peak').stream(primaryKey: ['id']).listen((event) {
      for (final record in event) {
        fetchParkingStats(record as String);
        //_handleParkingLotChange(record);
      }
    });

    /*
    // Programar eliminación de registros antiguos y creación de gráficos diariamente
    _cron.schedule(Schedule.parse('0 0 * * *'), () async {
      await _deleteOldRecords();
      await _createDailyGraph();
    });

    // Programar reset del booleano cada hora
    _cron.schedule(Schedule.parse('0 * * * *'), () async {
      _canCreatePeakHourRecord =
          _canCreatePeakHourRecord.map((key, value) => MapEntry(key, true));
    });
    */
  }

  /*
  Future<void> _initializeCanCreatePeakHourRecord() async {
    final response = await _supabase
        .from('parkingLot')
        .select('id')
        // ignore: deprecated_member_use
        .execute();

    if (response.error != null) {
      throw Exception('Failed to fetch parking lot ids');
    }

    final data = response.data as List<dynamic>;
    for (var item in data) {
      _canCreatePeakHourRecord[item['id']] = true;
    }
  }

  Future<void> _handleParkingLotChange(Map<String, dynamic> record) async {
    final int totalSpots = record['totalParkingSpace'];
    final int currentCars = record['cars'];
    final String parkingLotId = record['id'];
    final DateTime now = DateTime.now();

    // Crear registros de horas pico
    if (_canCreatePeakHourRecord[parkingLotId]!) {
      if (currentCars >= totalSpots) {
        await _createPeakHourRecord(parkingLotId, 'full', now);
        _canCreatePeakHourRecord[parkingLotId] = false;
      } else if (currentCars <= totalSpots / 4) {
        await _createPeakHourRecord(parkingLotId, 'available', now);
        _canCreatePeakHourRecord[parkingLotId] = false;
      }
    }
  }

  Future<void> _createPeakHourRecord(
      String parkingLotId, String type, DateTime timestamp) async {
    final dayOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ][timestamp.weekday - 1];
    // CREO QUE EL -1 NO ES NECESARIO

    final response = await _supabase.from('peak').insert({
      'idParkingLot': parkingLotId,
      'timestamp': timestamp.toIso8601String(),
      'dayOfWeek': dayOfWeek,
      'type': type,
      // ignore: deprecated_member_use
    }).execute();

    if (response.error != null) {
      throw Exception('Failed to create peak hour record');
    }
  }

  Future<void> _deleteOldRecords() async {
    final response = await _supabase
        .from('peak')
        .delete()
        .lt('timestamp',
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String())
        // ignore: deprecated_member_use
        .execute();

    if (response.error != null) {
      throw Exception('Failed to delete old records');
    }
  }
  */

  Future<void> _createDailyGraph(List<Peak> peaks) async {
    // Aquí va la lógica para crear la gráfica diaria
    // ...
  }

  // Método para obtener unicamente los peak nuevos
  // Original es con el parkingLotId
  Future<List<Peak>>? fetchParkingStats(String parkingLotId) async {
    final response = await _supabase
        .from('peak')
        .select()
        //.eq('idParkingLot', parkingLotId)
        .eq('id', parkingLotId)
        .gte('timestamp',
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String())
        // ignore: deprecated_member_use
        .execute();

    if (response.error != null) {
      throw Exception('Failed to fetch data');
    }

    final data = response.data as List<dynamic>;
    return transformParkingStats(data);
  }

  //Metodo para obtener los peak
  Future<List<Peak>>? fetchPeaks() async {
    final response = await _supabase
        .from('peak')
        .select()
        .gte('timestamp',
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String())
        // ignore: deprecated_member_use
        .execute();

    if (response.error != null) {
      throw Exception('Failed to fetch data');
    }

    final data = response.data as List<dynamic>;
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

extension on PostgrestResponse {
  get error => null;
}
