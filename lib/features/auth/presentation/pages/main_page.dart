import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/activity_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/home_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/services_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static final GlobalKey<_MainPageState> globalKey = GlobalKey();
  MainPage({Key? key}) : super(key: globalKey);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List pages = [
    HomePage(),
    ServicesPage(),
    ActivityPage(),
    UserPage()
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
        selectedItemColor: AppColors.textPrimary2,
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