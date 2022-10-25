import 'package:sqflite/sqflite.dart';

class DataBase {
  late DataBase _dataBase;

  static init() async {
    return await openDatabase('db_crud.db', version: 1,
        onCreate: (Database db, int version) {
      db.execute('''CREATE TABLE IF NOT EXISTS usuario(
            nombre TEXT,
            usuario TEXT, 
            password TEXT, 
            escolaridad TEXT, 
            estadoCivil TEXT, 
            habilidades TEXT)''');
    });
  }

  void close() {
    _dataBase.close();
  }
}
