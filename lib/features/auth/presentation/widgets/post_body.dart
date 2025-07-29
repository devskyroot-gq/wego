import 'package:flutter/material.dart';

class PostBody extends StatelessWidget {

  const PostBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: EdgeInsets.all(0),
      child: Image.asset("assets/images/map.PNG", fit: BoxFit.cover,),
    );
  }
}