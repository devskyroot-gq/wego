import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

  final List<String> images = [
    'assets/images/home_slide1.jpg',
    'assets/images/home_slide2.jpg',
    'assets/images/home_slide3.jpg',
  ];
  final List<String> imagesTitles = [
    '¿Taxi? ¡Pssss!',
    '¡Tu taxi en camino!',
    'Emprende tu viaje a tu destino.',
  ];

class HomeSlideshow extends StatelessWidget {
  HomeSlideshow({super.key});

  int index = 0;

  final List<Widget> imageSliders = images
    .map((item) => Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(item.toString(), fit: BoxFit.cover, width: double.maxFinite),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                          imagesTitles[images.indexOf(item)],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                ),
              ),
            ],
          )),
    ))
    .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.all(20),
      child: CarouselSlider(
          options: CarouselOptions(
            initialPage: 0,
            height: 160,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 6), 
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.easeInOut,
            scrollDirection: Axis.horizontal
          ),
          items: imageSliders
        ),
      
    );
  }

}

