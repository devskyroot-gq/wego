import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String? text;
  Color color;
  Color bgColor;
  Color borderColor;
  double? width;
  double? height;
  double borderRadius;
  IconData? icon;
  bool? isIcon;
  double? iconSize;
  AppButton({super.key, 
  this.text,
  this.color=AppColors.textPrimary, 
  this.bgColor=AppColors.primary,
  this.borderColor=Colors.transparent, 
  this.width=double.maxFinite/2, 
  this.height=50,
  this.borderRadius=15,
  this.icon,
  this.iconSize,
  this.isIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          strokeAlign: 1.0
        )
      ),
      child: isIcon==false?Center(child: AppLargeText(size: 16,text: text!, color: color,)):
        Center(child: Icon(icon,color: borderColor,size: iconSize,)),
    );
  }

}