import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/features/auth/presentation/pages/app_loadding_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/login_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConected});
  final Widget? pageIfNotConected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService, 
      builder: (context, auth, child){
        return StreamBuilder(
          stream: authService.value.userStream(),
          builder: (context, snapshot){
            Widget widget;
            if(snapshot.connectionState == ConnectionState.waiting){
              widget = AppLoaddingPage();
            }
            else if(snapshot.hasData){
              widget = StartPage();
            }else{
              widget = pageIfNotConected ?? LoginPage();
            }
            return widget;
          }
        );
      }
    );
  }
}