import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:segundo_parcial/controllers/user_controller.dart';
import 'package:segundo_parcial/screens/detalle_page.dart';
import 'package:segundo_parcial/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final listKey = GlobalKey<AnimatedListState>();
  final controller = Get.put(UserController());
  late SharedPreferences loginData;
  bool fill = false;
  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 160),
                child: Text('Usuarios'),
              ),
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      onTap: () async {
                        final data = await SharedPreferences.getInstance();
                        setState(() {
                          data.clear();
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                            (route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          Text('Cerrar sesión')
                        ],
                      ))
                ];
              })
            ],
          ),
        ),
        body: Obx(() {
          var itemCount = controller.user.length;
          return itemCount == 0
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : RefreshIndicator(
                  onRefresh: () => controller.refresh(),
                  color: Colors.black,
                  child: AnimatedList(
                    key: listKey,
                    initialItemCount: itemCount,
                    itemBuilder: (context, index, animation) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetallePage(
                                    user: controller.user[index],
                                  ))),
                      child: ListItemWidget(
                        item: controller.user[index],
                        animation: animation,
                      ),
                    ),
                  ),
                );
        }),
      ),
    );
  }

  _alert(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      style: const AlertStyle(isCloseButton: false),
      title: 'Confirmación',
      desc: '¿Declara que no entrega cantidad alguna de casco usado?',
      buttons: [
        DialogButton(
          onPressed: () async {
            final data = await SharedPreferences.getInstance();
            setState(() {
              data.clear();
            });
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false);
          },
          color: Colors.black,
          child: const Text(
            "Sí",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
          child: const Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ],
    ).show();
  }
}
