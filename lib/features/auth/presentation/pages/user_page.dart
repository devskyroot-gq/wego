import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/main_page.dart';
import 'package:demo_pss/features/auth/presentation/widgets/profile_card.dart';
import 'package:demo_pss/features/auth/presentation/widgets/user_option.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.bgCard)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nombre de usuarioo",
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            height: 0.9,
                          ),
                        ),
                        SizedBox(height: 4,),
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.bgCard,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.star_outline, size: 16),
                              Text("5.0"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      backgroundColor: AppColors.bgCard,
                      child: Icon(Icons.person, size: 60),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Ayuda! Disponible proximamente"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: ProfileCard(
                      text: "Ayuda",
                      icon: Icons.info,
                      bgColor: AppColors.bgCard,
                      borderRadius: 12,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Cartera! Disponible proximamente"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: ProfileCard(
                      text: "Cartera",
                      icon: Icons.wallet,
                      bgColor: AppColors.bgCard,
                      borderRadius: 12,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isActive);
                      MainPage.globalKey.currentState?.onTap(2);
                    },
                    child: ProfileCard(
                      text: "Actividad",
                      icon: Icons.local_activity,
                      bgColor: AppColors.bgCard,
                      borderRadius: 12,
                    ),
                  ),
                ],
              ),
            ),

            InkWell(
              onTap: () {
                
              },
              child: UserOption(
                title: "Ajustes",
                subtitle: "Editar los ajustes de la aplicacion",
                icon: Icons.settings,
                subtitleColor: AppColors.textSecondary,
                size2: 12,
              ),
            ),
            InkWell(
              onTap: () {
                
              },
              child: UserOption(
                title: "Cuenta",
                subtitle: "Administracion de la cuenta",
                icon: Icons.person,
                subtitleColor: AppColors.textSecondary,
                size2: 12,
              ),
            ),
            InkWell(
              onTap: () {
                
              },
              child: UserOption(
                title: "Acerca de nosotros",
                subtitle: "Sobre nosotros, politicas de privacidad",
                icon: Icons.info,
                subtitleColor: AppColors.textSecondary,
                size2: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
