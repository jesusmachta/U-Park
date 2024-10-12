class User {
  String id;
  String email;
  String password;

  User({
    required this.id,
    required this.email,
    required this.password,
  });

  // Método para convertir la tarea a un mapa (útil para almacenar en bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  // Método para crear una tarea desde un mapa
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }
}
