import 'dart:developer';
import 'package:get/get.dart';
import 'package:segundo_parcial/models/usuario.dart';
import 'package:segundo_parcial/repository/user_repository.dart';

class UserController extends GetxController {
  final user = <Usuario>[].obs;

  Future<void> getData() async {
    try {
      //if (user.isEmpty) {
      final newUser = await Get.find<UserRespository>().getAllUsers();
      newUser.forEach((element) {
        user.insert(0, element);
      });
      //}
      //user.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> refresh() async {
    user.clear();
    getData();
  }
}
