import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial/controllers/user_controller.dart';
import 'package:segundo_parcial/data_source/db_data_source.dart';
import 'package:segundo_parcial/repository/user_repository.dart';
import 'package:segundo_parcial/screens/login.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late Database _db;
  _db = await DataBase.init();
  final userRepo = Get.put(UserRespository(_db));
  Get.put(userRepo);
  Get.put(UserController().getData());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
