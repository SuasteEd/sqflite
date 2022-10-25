import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:segundo_parcial/models/usuario.dart';
import 'package:segundo_parcial/screens/detalle_page.dart';

class ListItemWidget extends StatelessWidget {
  final Usuario item;
  final Animation<double> animation;
  ListItemWidget({Key? key, required this.item, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) => buildItem();
  Widget buildItem() => Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/user.png'),
          ),
          title: Text(
            item.nombre,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(item.escolaridad),
          trailing: IconButton(
            icon: const Icon(
              Icons.expand_more,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      );
}
