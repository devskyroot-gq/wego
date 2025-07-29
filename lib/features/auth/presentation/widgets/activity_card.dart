import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? bgColor;
  final double? borderRadius;
  final Color? borderColor;
  final IconData icon;
  final String username;
  final String location;
  final String destination;
  const ActivityCard({
    super.key,
    this.height,
    this.width,
    this.bgColor,
    this.borderRadius = 15,
    this.borderColor = Colors.transparent,
    this.icon = Icons.grid_3x3,
    required this.username, 
    required this.location, 
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius!),
        border: Border.all(color: borderColor!, style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage("assets/images/user.png"),),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary2),),
                  Text(location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textPrimary2),),
                  Text(destination, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textPrimary2),)
                ],
              )
            ],
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
