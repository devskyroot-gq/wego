import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DriverNotificationCard extends StatelessWidget {
  final String driverName;
  final String? driverImg;
  final String carEnrollmentNumber;
  final String? distance;
  final double? ratingStars;
  const DriverNotificationCard({super.key, required this.driverName, required this.carEnrollmentNumber, this.distance, this.driverImg, this.ratingStars});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(driverImg ?? "assets/images/user.png"),),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLargeText(text: driverName, size: 16, color: AppColors.textPrimary,),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                    itemSize: 14,
                    itemBuilder: (context, index) {
                      return Icon(Icons.star, color: Colors.amber,);
                    },
                    onRatingUpdate: (value) {
                      
                    },
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Matricula: $carEnrollmentNumber"),
              Text("Distancia: $distance"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: null, 
                padding: EdgeInsets.all(4),
                icon: Icon(Icons.cancel_outlined, size: 30, color: Colors.red,)
              ),
              //SizedBox(width: 10,),
              IconButton(
                onPressed: null,
                padding: EdgeInsets.all(4),
                icon: Icon(Icons.check_circle_outlined, size: 30, color: Colors.green,)
              ),
            ],
          )
        ]
      ),
    );
  }
}