import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? actionbar;
  const CustomAppBar({super.key, required this.title, this.actionbar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: BorderDirectional(bottom: BorderSide(color: Colors.grey.shade300))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: AppLeadingButton(
                iconColor: AppColors.textPrimary,
                bgColor: Colors.transparent,
                marginRight: 0,
                marginLeft: 0,
              )
            ),
            AppLargeText(size: 24, text: title, color: AppColors.textPrimary),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: actionbar,
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}