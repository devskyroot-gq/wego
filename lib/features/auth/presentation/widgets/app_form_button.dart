import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class AppFormButton extends StatelessWidget {
  final void Function() onpress;
  final String text;
  final Color? color;
  final Color? textColor;
  final double width;
  final double height;
  const AppFormButton({super.key, 
    required this.onpress, 
    required this.text, 
    this.textColor, 
    this.width=double.maxFinite, 
    this.height=50, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress, 
      style: ElevatedButton.styleFrom(
        animationDuration: Durations.long4,
        disabledBackgroundColor: AppColors.primaryShade300,
        backgroundColor: color ?? AppColors.primary,
        foregroundColor: textColor ?? AppColors.background,
        //minimumSize: Size.infinite,
        padding: EdgeInsets.zero,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: AppLargeText(text: text, size: 18, color: AppColors.background,)
    );
  }
}