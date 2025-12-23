import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/activity_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/home_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/services_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/user_page_passenger.dart';
import 'package:flutter/material.dart';

class MainPagePassenger extends StatefulWidget {
  static final GlobalKey<_MainPagePassengerState> globalKey = GlobalKey();
  MainPagePassenger({Key? key}) : super(key: globalKey);

  @override
  State<MainPagePassenger> createState() => _MainPagePassengerState();
}

class _MainPagePassengerState extends State<MainPagePassenger> {

  List pages = [
    HomePagePassenger(),
    ServicesPagePassenger(),
    ActivityPagePassenger(),
    UserPagePassenger()
  ];

  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0; 
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        iconSize: 30,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: AppColors.textSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 20,
        items: [
          BottomNavigationBarItem(label: "Inicio", icon: Icon(Icons.home),),
          BottomNavigationBarItem(label: "Servicios", icon: Icon(Icons.apps)),
          BottomNavigationBarItem(label: "Actividad", icon: Icon(Icons.local_activity)),
          BottomNavigationBarItem(label: "Mi perfil", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}