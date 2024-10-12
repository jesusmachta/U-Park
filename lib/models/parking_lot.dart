class ParkingLot {
  String id;
  String name;
  String? location;
  int totalParkingSpace;
  int cars;

  ParkingLot({
    required this.id,
    required this.name,
    this.location,
    required this.totalParkingSpace,
    required this.cars,
  });

  // Método para convertir la tarea a un mapa (útil para almacenar en bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'total_parking_space': totalParkingSpace,
      'cars': cars,
    };
  }

  // Método para crear una tarea desde un mapa
  factory ParkingLot.fromMap(Map<String, dynamic> map) {
    return ParkingLot(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      totalParkingSpace: map['total_parking_space'],
      cars: map['cars'],
    );
  }
}
