import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/post_page_detail.dart';
import 'package:demo_pss/features/auth/presentation/widgets/activity_card.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/home_slideshow.dart';
import 'package:demo_pss/features/auth/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePagePassenger extends StatefulWidget {
  const HomePagePassenger({super.key});

  @override
  State<HomePagePassenger> createState() => _HomePagePassengerState();
}

final List<String> users = [
  "Nombre de usuario",
  "Nombre de usuario",
];

final List<String> usersDestination = [
  "Los Angeles",
  "Semu",
];

final List<String> usersLocation = [
  "Hassan II",
  "Sumco",
];


class _HomePagePassengerState extends State<HomePagePassenger> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(left: 10, right: 10),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: AppLargeText(
            size: 28,
            text: "We Go",
            color: AppColors.textPrimary,
          ),
        ),
        
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeSlideshow(),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: AppLargeText(size:18, text: "Mis proximos viajes", color: Colors.black54,),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                  itemCount: users.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostPageDetail(username: users[index],location: usersDestination[index],),));
                      },
                      child: ActivityCard(
                            width: double.maxFinite,
                            username: users[index],
                            location: "Ub: ${usersLocation[index]}",
                            destination: "Des: ${usersDestination[index]}",
                            icon: Icons.keyboard_arrow_right,
                            bgColor: Colors.grey.shade300,
                            borderRadius: 15,
                          ),
                    );
                  },
                  
                ),
              ),
            ),
            
          ]
        ),
      ),
    );
  }
}
