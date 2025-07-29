import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? bgColor;
  final double? borderRadius;
  final Color? borderColor;
  final IconData icon;
  final String text;
  const ProfileCard({super.key, 
  this.height, 
  this.width, 
  this.bgColor, 
  this.borderRadius=15, 
  this.borderColor=Colors.transparent, this.icon=Icons.grid_3x3, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10,bottom: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius!),
        border: Border.all(
          color: borderColor!,
          style: BorderStyle.solid
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(
            text,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}