import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 70),
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Row(
            children: [
              AppLargeText(size: 30, text: "Usuario", color: Colors.black),
              Expanded(child: Container(width: double.maxFinite,)),
              Icon(Icons.person_rounded, size: 30,)
            ],
          ),
        ),  
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}