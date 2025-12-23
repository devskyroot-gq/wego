import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/driver_notification_cart.dart';
import 'package:flutter/material.dart';

class PassengerNotificationPage extends StatefulWidget {
  const PassengerNotificationPage({super.key});

  @override
  State<PassengerNotificationPage> createState() => _PassengerNotificationPageState();
}

class _PassengerNotificationPageState extends State<PassengerNotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          title: "Notificaciones"
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO driver notification item
              DriverNotificationCard(
                driverName: "Tomas",
                carEnrollmentNumber: "KN-809-KL",
                distance: "400m",
              ),
            ],
          ),
        ),
      ),
    );
  }
}