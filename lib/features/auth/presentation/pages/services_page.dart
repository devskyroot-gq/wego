import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 70),
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Row(
            children: [
              AppLargeText(size: 30, text: "Servicios", color: Colors.black),
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