import 'package:flutter/material.dart';

class AppLeadingButton extends StatelessWidget {
  final Color? iconColor;
  final Color? bgColor;
  final IconData? icon;
  final double? width;
  final double? height;
  final double? marginLeft;
  final double? marginRight;
  const AppLeadingButton({
    super.key,
    this.iconColor = Colors.black,
    this.bgColor = Colors.white,
    this.icon = Icons.arrow_back_outlined,
    this.width = 50,
    this.height = 50, 
    this.marginLeft=10, 
    this.marginRight=10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: marginLeft!, right: marginRight!),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(Icons.arrow_back_outlined, color: iconColor),
    );
  }
}
