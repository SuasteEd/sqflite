class Usuario {
  String nombre;
  String usuario;
  String password;
  String escolaridad;
  String estadoCivil;
  String habilidades;

  Usuario(this.nombre, this.usuario, this.password, this.escolaridad,
      this.estadoCivil, this.habilidades);

  Usuario.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        usuario = map['usuario'],
        password = map['password'],
        escolaridad = map['escolaridad'],
        estadoCivil = map['estadoCivil'],
        habilidades = map['habilidades'];

  Map<String, dynamic> toMapForDb() {
    return {
      'nombre': nombre,
      'usuario': usuario,
      'password': password,
      'escolaridad': escolaridad,
      'estadoCivil': estadoCivil,
      'habilidades': habilidades
    };
  }
}
