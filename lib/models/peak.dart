class Peak {
  String id;
  DateTime
      timestamp; //Tambien lo pudiesemos tener como String, lo que sea mejor para el manejo de la stat
  String dayOfWeek;
  String type;
  String idParkingLot;

  Peak({
    required this.id,
    required this.timestamp,
    required this.dayOfWeek,
    required this.type,
    required this.idParkingLot,
  });

  // Método para convertir la tarea a un mapa (útil para almacenar en bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'dayOfWeek': dayOfWeek,
      'type': type,
      'idParkingLot': idParkingLot,
    };
  }

  // Método para crear una tarea desde un mapa
  factory Peak.fromMap(Map<String, dynamic> map) {
    return Peak(
      id: map['id'],
      timestamp: map['timestamp'],
      dayOfWeek: map['dayOfWeek'],
      type: map['type'],
      idParkingLot: map['idParkingLot'],
    );
  }
}
