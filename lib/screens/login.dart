import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:segundo_parcial/controllers/user_controller.dart';
import 'package:segundo_parcial/screens/home_page.dart';
import 'package:segundo_parcial/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences loginData;
  final username = TextEditingController();
  final password = TextEditingController();
  final controller = Get.put(UserController());
  bool isLoading = false;
  bool isLogin = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  void checkIfIsLogin() async {
    loginData = await SharedPreferences.getInstance();
    isLogin = loginData.getBool('login') ?? false;
    if (isLogin == true) {
      _openPage();
    }
  }

  @override
  void initState() {
    checkIfIsLogin();
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 130,
                    ),
                    const Text(
                      "Inicio de sesión",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "¡Bienvenido!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Por favor, ingresa tus datos",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    const Text(
                      "Usuario",
                      style: TextStyle(
                        color: Color.fromARGB(255, 46, 2, 2),
                        fontSize: 13,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: TextFormField(
                          controller: username,
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.account_circle_outlined,
                              ),
                              hintText: "Ingresa tu usuario",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Contraseña",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: TextFormField(
                          controller: password,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.lock,
                            ),
                            hintText: "Ingresa tu contraseña",
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: const [
                        Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            validate();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            child: Row(
                              children: [
                                const Text(
                                  "Iniciar sesión",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                showIcon(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("¿No tienes una cuenta?"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey,
                            ),
                            child: const Text("Registrarse"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  validate() {
    if (username.text.isEmpty || password.text.isEmpty) {
      showAlert(context, 'Campos vacíos', 'Complete todos los campos');
    } else {
      if (!isLoading) {
        setState(() {
          isLoading = true;
          login();
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void login() async {
    controller.getData();
    var list = controller.user
        .where((element) => element.usuario == username.text)
        .toList();
    if (list.isNotEmpty) {
      var user = list[0];
      if (user.password == password.text) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
        loginData.setBool('login', true);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showAlert(
          context, 'Datos incorrectos', 'Usuario o contraseña incorrectos');
    }
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

  void _openPage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }

  Widget showIcon() {
    if (isLoading) {
      return Container(
        height: 15,
        width: 15,
        margin: const EdgeInsets.only(left: 5),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return const Icon(
      Icons.arrow_forward,
      color: Colors.white,
    );
  }
}
