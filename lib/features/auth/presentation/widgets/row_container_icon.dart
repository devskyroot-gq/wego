import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class RowContainerIcon extends StatelessWidget {
  final String text;
  final Icon icon;
  const RowContainerIcon({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,),
        Expanded(
          child: Placeholder()
        ),
        icon
      ],
    );
  }
}