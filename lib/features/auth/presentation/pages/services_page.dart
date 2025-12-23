import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/card_service.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

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
            AppLargeText(text: "¿Que deseas hacer?", size: 20, color: AppColors.textPrimary2,),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Cash out! Disponible proximamente"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: CardService(text: "Cash out", 
                icon: Icons.attach_money_outlined, 
                bgColor: AppColors.bgCard,
                width: double.maxFinite,
              ),
            ),

            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Transferencia! Disponible proximamente"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: CardService(text: "Transferencia", 
                icon: Icons.mobile_screen_share_outlined, 
                bgColor: AppColors.bgCard,
                width: double.maxFinite,
              ),
            ),

            /*InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTaxiPage()));
              },
              child: CardService(text: "Pedir taxi", 
                icon: Icons.local_taxi, 
                bgColor: Colors.grey.shade300,
                width: double.maxFinite,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}