import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/cashout_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/order_taxi_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/transfer_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/card_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesPagePassenger extends StatelessWidget {
  const ServicesPagePassenger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppLargeText(size: 24, text: "Servicios", color: Colors.black),
        shape: Border(
          bottom: BorderSide(
            color: AppColors.bgCard,
          )
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20,top: 20,right: 20),
        child: Column(
          children: [
            AppLargeText(text: "¿Que deseas hacer?", size: 20, color: Colors.black45,),
            InkWell(
              onTap: () {
                Get.to(() => CashoutPagePassenger(), transition: Transition.rightToLeft);
              },
              child: CardService(text: "Cash out", 
                icon: Icons.attach_money_outlined, 
                bgColor: AppColors.bgCard,
                width: double.maxFinite,
              ),
            ),

            InkWell(
              onTap: () {
                Get.to(() => TransferPagePassenger(), transition: Transition.rightToLeft);
              },
              child: CardService(text: "Transferencia", 
                icon: Icons.mobile_screen_share_outlined, 
                bgColor: AppColors.bgCard,
                width: double.maxFinite,
              ),
            ),

            InkWell(
              onTap: () {
                Get.to(() => OrderTaxiPage(), transition: Transition.rightToLeft);
              },
              child: CardService(text: "Pedir taxi", 
                icon: Icons.local_taxi, 
                bgColor: AppColors.bgCard,
                width: double.maxFinite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}