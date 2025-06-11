import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 70),
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Row(
            children: [
              AppLargeText(size: 30, text: "Actividad", color: Colors.black),
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