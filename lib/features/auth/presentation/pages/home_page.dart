import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/post_page_detail.dart';
import 'package:demo_pss/features/auth/presentation/widgets/activity_card.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/home_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> users = [
  "Usuario 1",
  "Usuario 2",
  "Usuario 3",
  "Usuario 4",
  "Usuario 5",
  "Usuario 6",
  "Usuario 7",
  "Usuario 8",
];

final List<String> usersDestination = [
  "Los Angeles",
  "Semu",
  "Santa Maria III",
  "Ela Nguema",
  "San Juan",
  "Fistown",
  "Hassan II",
  "Sumco",
];

final List<String> usersLocation = [
  "Ubicacion uno",
  "Ubicacion dos",
  "Ubicacion tres",
  "Ela Nguema",
  "San Juan",
  "Fistown",
  "Hassan II",
  "Sumco",
];


class _HomePageState extends State<HomePage> {

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
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(left: 10, top: 4, right: 10, bottom: 4),
        //     child: InkWell(
        //       onTap: () {},
        //       child: Icon(
        //         Icons.refresh_rounded,
        //         size: 28,
        //         color: AppColors.textPrimary,
        //       ),
        //     ),
        //   ),
        //   Padding(
        //     padding: EdgeInsets.all(10.0),
        //     child: InkWell(
        //       onTap: () {},
        //       child: Icon(
        //         Icons.settings,
        //         size: 28,
        //         color: AppColors.textPrimary,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      backgroundColor: AppColors.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeSlideshow(),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: AppLargeText(size:18, text: "Solicitudes de viajes", color: AppColors.textPrimary2,),
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
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => PostPageDetail(username: users[index],location: usersDestination[index],),));
                      },
                      child: ActivityCard(
                            width: double.maxFinite,
                            username: users[index],
                            location: "Ub: ${usersLocation[index]}",
                            destination: "Des: ${usersDestination[index]}",
                            icon: Icons.keyboard_arrow_right,
                            bgColor: AppColors.bgCard,
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
