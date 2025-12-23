import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/data/models/user_model.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/features/auth/presentation/pages/app_loadding_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/login_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/main_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/main_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  // final data = authService.value.getCurrentUserData();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.value.userStream(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return AppLoaddingPage();
        }
        final user = snapshot.data;
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.background),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.inherit,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      "assets/images/logo-black.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: double.maxFinite, height: 60),
                  AppLargeText(text: "¡Bienvenido!"),
                  AppLargeText(
                    text: "${user?["Username"]}",
                    color: AppColors.textPrimary2,
                  ),
                  SizedBox(width: double.maxFinite, height: 10),
                  AppLargeText(
                    text: "¿Cómo planea usar la aplicación?",
                    size: 18,
                    color: Colors.black54,
                  ),
                  SizedBox(width: double.maxFinite, height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              authService.value.setUserType("Conductor");
                              Get.off(() => MainPage());
                            },
                            child: AppButton(
                              isIcon: true,
                              icon: Icons.drive_eta_outlined,
                              height: 100,
                              width: 100,
                              bgColor: AppColors.inherit,
                              borderColor: AppColors.secondary,
                              iconSize: 50,
                            ),
                          ),
                          AppLargeText(
                            text: "Conductor",
                            color: AppColors.secondary,
                            size: 16,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              authService.value.setUserType("Pasajero");
                              Get.off(() => MainPagePassenger());
                            },
                            child: AppButton(
                              isIcon: true,
                              icon: Icons.hail_rounded,
                              height: 100,
                              width: 100,
                              bgColor: AppColors.inherit,
                              borderColor: AppColors.secondary,
                              iconSize: 50,
                            ),
                          ),
                          AppLargeText(
                            text: "Pasajero",
                            color: AppColors.secondary,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
