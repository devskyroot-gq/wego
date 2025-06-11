import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/home_slideshow.dart';
import 'package:demo_pss/features/auth/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(left: 10, right: 10),
        elevation: 0,
        backgroundColor: AppColors.background,
        title: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: AppLargeText(
            size: 28,
            text: "We Go",
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 4, right: 10, bottom: 4),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.refresh_rounded,
                size: 28,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.settings,
                size: 28,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeSlideshow(),
            //TODO cards items
            
            
            //PostCard(heigth: 100, width: double.maxFinite,color: Colors.blueGrey,),
            
          ]
        ),
      ),
    );
  }
}
