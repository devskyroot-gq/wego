import 'package:flutter/material.dart';

class UserOption extends StatelessWidget {

  final IconData? icon;
  final Widget? trailingWidget;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final Color? subtitleColor;
  final double? size;
  final double? size2;

  const UserOption({super.key, this.icon, required this.title, this.subtitle, this.titleColor, this.subtitleColor, this.size, this.size2, this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontSize: size, color: titleColor),),
      subtitle: subtitle!.isNotEmpty ? Text(subtitle!, style: TextStyle(fontSize: size2, color: subtitleColor),) : null,
      trailing: trailingWidget,
    );
  }
}