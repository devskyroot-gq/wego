import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTaxiController extends GetxController {
  var currentUser = authService.value.getCurrentUserData();
  GeoPoint? source;
  GeoPoint? destination;
  final sourceLabel = TextEditingController();
  final destinationLabel = TextEditingController();
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
    sourceLabel.clear();
    destinationLabel.clear();
    ableToPay.clear();
    travelTime.clear();
  }


}