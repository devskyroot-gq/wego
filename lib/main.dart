import 'package:demo_pss/core/utils/trip_functions.dart';
import 'package:demo_pss/data/repositories/passenger_map_repository.dart';
import 'package:demo_pss/data/repositories/trip_repository.dart';
import 'package:demo_pss/features/auth/auth_layout.dart';
import 'package:demo_pss/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 300));
  //firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  //tripRepo inicilization
  Get.put(TripRepository(), permanent: true);
  //trip functions
  Get.put(TripFunctions(), permanent: true);
  //map repo
  Get.put(PassengerMapRepository(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthLayout(),
    );
  }
}
