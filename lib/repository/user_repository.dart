import 'package:segundo_parcial/models/usuario.dart';
import 'package:sqflite/sqflite.dart';

class UserRespository {
  late Database _dataBase;
  UserRespository(Database db) {
    _dataBase = db;
  }

  Future<List<Usuario>> getAllUsers() async {
    List data = await _dataBase.rawQuery('SELECT * FROM usuario');
    var lista = data
        .map((item) => Usuario(
            item['nombre'],
            item['usuario'],
            item['password'],
            item['escolaridad'],
            item['estadoCivil'],
            item['habilidades']))
        .toList();
    return lista;
  }

  register(Usuario user) async {
    var map = user.toMapForDb();
    await _dataBase.insert('usuario', map);
  }
}
