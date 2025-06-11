import 'package:demo_pss/features/auth/presentation/widgets/row_container_icon.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      color: Colors.grey,
      padding: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowContainerIcon(text: "Ubicacion", icon: Icon(Icons.location_on_rounded),),
                RowContainerIcon(text: "Destino", icon: Icon(Icons.stop),),
                RowContainerIcon(text: "Precio", icon: Icon(Icons.money_rounded),)
              ],
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
              )
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.lightGreen,
              child: Center(
                child: Icon(Icons.hail_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}