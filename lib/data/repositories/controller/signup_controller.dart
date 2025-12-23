import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/data/models/user_model.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/features/auth/presentation/pages/login_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/phone_verification_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  //call user repository
  final userRepository = Get.put(UserRepository());
  //call the firebase auth
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //for the phone verification
  String message = "";
  String verificationId = "";
  String phoneNo = "";
  String code = "";

  //textfields controllers to get data
  final name = TextEditingController();
  final surname = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();

  resetForm() {
    name.clear();
    surname.clear();
    phone.clear();
    email.clear();
    username.clear();
    password.clear();
    password2.clear();
  }

}