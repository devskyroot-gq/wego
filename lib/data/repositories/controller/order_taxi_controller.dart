import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderTaxiController extends GetxController {
  var currentUser = authService.value.getCurrentUserData();
  final latitude = "";
  final length = "";
  final locationLabel = TextEditingController();
  final destination = TextEditingController();
  final ableToPay = TextEditingController();
  final travelTime = TextEditingController();
  final time = TextEditingController();
  final user = "";
  final img = "";
  final driver = "";
  final enrollment = "";
  final driverConfirmation = false;
  final userConfirmation = false;
  
  //reset form
  resetForm(){
    locationLabel.clear();
    destination.clear();
    ableToPay.clear();
    travelTime.clear();
  }


}