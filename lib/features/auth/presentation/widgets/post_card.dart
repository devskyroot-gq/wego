import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String img;
  final String title;
  final String subtitle;
  final String? timeAgo;
  const PostCard({super.key,  this.img="assets/images/user.png", required this.title, required this.subtitle, this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 4),
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(img),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary2),),
                        Text(subtitle, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textPrimary2),)
                      ]
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(Icons.keyboard_arrow_right_outlined, size: 40, color: AppColors.textSecondary,),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                timeAgo!, 
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondary),
                )
            )
          ],
        ),
      ),
    );
  }
}
