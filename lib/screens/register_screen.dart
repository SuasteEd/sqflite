import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:segundo_parcial/controllers/user_controller.dart';
import 'package:segundo_parcial/data_source/db_data_source.dart';
import 'package:segundo_parcial/models/usuario.dart';
import 'package:segundo_parcial/repository/user_repository.dart';
import 'package:segundo_parcial/screens/login.dart';
import 'package:sqflite/sqflite.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nombre = TextEditingController();
  final usuario = TextEditingController();
  final password = TextEditingController();
  final escolaridad = TextEditingController();
  final estadoCivil = TextEditingController();
  final habilidades = TextEditingController();
  late final UserRespository repo;
  late Database _database;
  List<String> items = <String>[
    'Escolaridad',
    'Licenciatura',
    'Maestría',
    'Doctorado'
  ];
  String dropdownValue = 'Escolaridad';
  bool isCheckedJava = false;
  bool isCheckedC = false;
  bool isCheckedCC = false;
  String? estado;
  var user = Get.put(UserController());
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    _database = await DataBase.init();
    repo = UserRespository(_database);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Login()));
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Padding(
                  padding: EdgeInsets.only(right: 163),
                  child: Text('Registro'),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Usuario",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: TextFormField(
                      controller: usuario,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.account_circle,
                          ),
                          hintText: "Ingresa tu usuario",
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Nombre",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: TextFormField(
                      controller: nombre,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.contact_page,
                          ),
                          hintText: "Ingresa tu nombre",
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Contraseña",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock,
                          ),
                          hintText: "Ingresa una contraseña",
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Escolaridad",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: DropdownButton(
                      underline: Container(),
                      isExpanded: true,
                      dropdownColor: Colors.grey[300],
                      elevation: 5,
                      iconSize: 36,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value!;
                          escolaridad.text = value;
                        });
                      },
                      value: dropdownValue,
                      items: items.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Estado civil",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Casado'),
                          Radio(
                            value: 'Casado',
                            groupValue: estado,
                            onChanged: (value) {
                              setState(() {
                                estado = value.toString();
                                estadoCivil.text = estado!;
                              });
                            },
                          ),
                          const Text('Soltero'),
                          Radio(
                            value: 'Soltero',
                            groupValue: estado,
                            onChanged: (value) {
                              setState(() {
                                estado = value.toString();
                                estadoCivil.text = estado!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Habilidades",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Java'),
                          Checkbox(
                            value: isCheckedJava,
                            activeColor: Colors.black,
                            onChanged: (bool? value) {
                              setState(() {
                                habilidades.text += 'Java ';
                                isCheckedJava = value!;
                              });
                            },
                          ),
                          const Text('C#'),
                          Checkbox(
                            value: isCheckedC,
                            activeColor: Colors.black,
                            onChanged: (bool? value) {
                              setState(() {
                                habilidades.text += 'C# ';
                                isCheckedC = value!;
                              });
                            },
                          ),
                          const Text('C++'),
                          Checkbox(
                            value: isCheckedCC,
                            activeColor: Colors.black,
                            onChanged: (bool? value) {
                              setState(() {
                                habilidades.text += 'C++ ';
                                isCheckedCC = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        registrar();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Row(
                          children: const [
                            Text(
                              "Registrar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.save,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registrar() async {
    try {
      if (validate()) {
        var modelo = Usuario(nombre.text, usuario.text, password.text,
            escolaridad.text, estadoCivil.text, habilidades.text);
        await repo.register(modelo);
        openPage();
      }
    } catch (e) {
      log(e.toString());
    }
    Get.put(UserController()).getData();
  }

  void openPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  bool validate() {
    if (usuario.text.isEmpty ||
        nombre.text.isEmpty ||
        password.text.isEmpty ||
        escolaridad.text.isEmpty ||
        estadoCivil.text.isEmpty ||
        escolaridad.text == 'Escolaridad') {
      showAlert(context, 'Campos vacíos', 'Complete todos los campos');
      return false;
    }
    if (user.user.where((e) => usuario.text == e.usuario).isNotEmpty) {
      showAlert(context, 'Usuario duplicado', 'El usuario ingresado ya existe');
      return false;
    }
    if (password.text.length < 5) {
      showAlert(
          context, 'Contraseña invalida', 'Su contraseña es demasiado corta');
      return false;
    }
    return true;
  }

  void showAlert(context, String title, String contenido) {
    Alert(
      context: context,
      style: const AlertStyle(isCloseButton: false),
      type: AlertType.error,
      title: title,
      desc: contenido,
      buttons: [
        DialogButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
}
