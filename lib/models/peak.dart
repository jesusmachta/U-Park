class Peak {
  String id;
  String timestamp;
  bool type;
  String idPrkingLot;

  Peak({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.idPrkingLot,
  });

  // Método para convertir la tarea a un mapa (útil para almacenar en bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'type': type,
      'idParkingLot': idPrkingLot,
    };
  }

  // Método para crear una tarea desde un mapa
  factory Peak.fromMap(Map<String, dynamic> map) {
    return Peak(
      id: map['id'],
      timestamp: map['timestamp'],
      type: map['type'],
      idPrkingLot: map['idParkingLot'],
    );
  }
}
