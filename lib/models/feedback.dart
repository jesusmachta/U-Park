class FeedBack {
  String id;
  String date;
  String message;
  String? firstName;
  String? lastName;

  FeedBack({
    required this.id,
    required this.date,
    required this.message,
    this.firstName,
    this.lastName,
  });

  // Método para convertir la tarea a un mapa (útil para almacenar en bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'message': message,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  // Método para crear una tarea desde un mapa
  factory FeedBack.fromMap(Map<String, dynamic> map) {
    return FeedBack(
      id: map['id'],
      date: map['date'],
      message: map['message'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }
}
