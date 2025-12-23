import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String? text;
  final double? width;
  final double? heght;
  final Color? bgColor;
  const LoadingDialog({
    super.key, 
    this.text="Procesando...", 
    this.width=double.maxFinite, 
    this.bgColor=AppColors.background, this.heght=80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: heght,
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 20,),
          Text("Procesando...", style: TextStyle(color: AppColors.textPrimary2, fontSize: 16)),
        ],
      ),
      );
  }
}