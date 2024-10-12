class Peak {
  String id;
  String timestamp;
  String date;
  bool type;
  String idPrkingLot;

  Peak({
    required this.id,
    required this.timestamp,
    required this.date,
    required this.type,
    required this.idPrkingLot,
  });

  // Método para convertir la tarea a un mapa (útil para almacenar en bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'date': date,
      'type': type,
      'idParkingLot': idPrkingLot,
    };
  }

  // Método para crear una tarea desde un mapa
  factory Peak.fromMap(Map<String, dynamic> map) {
    return Peak(
      id: map['id'],
      timestamp: map['timestamp'],
      date: map['date'],
      type: map['type'],
      idPrkingLot: map['idParkingLot'],
    );
  }
}
