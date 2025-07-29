import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/main_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/main_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.background,

        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Image.asset("assets/images/logo-black.png", fit: BoxFit.cover,),
              ),
              SizedBox(width: double.maxFinite, height: 150,),
              AppLargeText(text: "¡Bienvenido!"),
              SizedBox(width: double.maxFinite, height: 10,),
              AppLargeText(text: "¿Cómo planea usar la aplicación?", size: 18, color: Colors.black54,),
              SizedBox(width: double.maxFinite, height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                        },
                        child: AppButton(isIcon: true, 
                        icon: Icons.drive_eta_outlined, 
                        height: 100, 
                        width: 100, 
                        bgColor: Colors.transparent,
                        borderColor: Colors.blue,
                        iconSize: 50,
                        ),
                      ),
                      AppLargeText(text: "Conductor", color: Colors.blue,size: 16,)
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPagePassenger()));
                        },
                        child: AppButton(isIcon: true, 
                        icon: Icons.hail_rounded, 
                        height: 100, 
                        width: 100, 
                        bgColor: Colors.transparent,
                        borderColor: Colors.blueGrey,
                        iconSize: 50,
                        ),
                      ),
                      AppLargeText(text: "Pasajero", color: Colors.blueGrey,size: 16,)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}