import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  //call user repository
  final userRepository = Get.put(UserRepository());
  //call the firebase auth
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //textfields
  final phone = TextEditingController();
  final password = TextEditingController();

}