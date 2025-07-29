import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? page;
  const CustomAppBar({super.key, required this.title, this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: BorderDirectional(bottom: BorderSide(color: Colors.grey.shade300))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (contex) => page));
              },
              child: AppLeadingButton(
                iconColor: Colors.black,
                bgColor: Colors.transparent,
                marginRight: 0,
                marginLeft: 0,
              )
            ),
            AppLargeText(size: 24, text: title, color: Colors.black),
          ],
        ),
      ),
    );
  }
}