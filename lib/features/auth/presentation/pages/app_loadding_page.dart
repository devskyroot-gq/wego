import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoaddingPage extends StatelessWidget {
  const AppLoaddingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.9,
            child: ColoredBox(color: AppColors.background),
          ),
        ),
        Center(
          child: CircularProgressIndicator(color: AppColors.primary, padding: EdgeInsets.all(10),),
        ),
      ]
    );
  }
}