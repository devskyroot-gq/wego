import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/widgets/activity_card.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class ActivityPagePassenger extends StatefulWidget {
  const ActivityPagePassenger({super.key});

  @override
  State<ActivityPagePassenger> createState() => _ActivityPagePassengerState();
}

final List<String> users = [
  "Usuario 1",
  "Usuario 2",
  "Usuario 3",
];

final List<String> usersLocation = [
  "Ubicacion uno",
  "Ubicacion dos",
  "Ubicacion tres",

];

final List<String> usersDestination = [
  "Los Angeles",
  "Semu",
  "Santa Maria III",

];

class _ActivityPagePassengerState extends State<ActivityPagePassenger> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {

  TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppLargeText(size: 24, text: "Actividad", color: Colors.black),
        shape: Border(
          bottom: BorderSide(
            color: AppColors.bgCard,
          )
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(left: 20,top: 20,right: 20),
        child: Column(
           children: [
            Container(
              child: TabBar(
                controller: tabController,
                tabs: [
                Tab(text: "Pendiente",),
                Tab(text: "Finalizado",)
              ]),
            ),
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              padding: EdgeInsets.all(0),
              child: TabBarView(
                controller: tabController,
                children: [
                  ListView.builder(
                    itemCount: users.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          
                        },
                        child: ActivityCard(
                          width: double.maxFinite,
                          username: users[index],
                          location: "Ub: ${usersLocation[index]}",
                          destination: "Des: ${usersDestination[index]}",
                          icon: Icons.access_time_filled,
                          bgColor: AppColors.bgCard,
                          borderRadius: 15,
                        )
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: users.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          
                        },
                        child: ActivityCard(
                          width: double.maxFinite,
                          username: users[index],
                          location: "Ub: ${usersLocation[index]}",
                          destination: "Des: ${usersDestination[index]}",
                          icon: Icons.check_circle,
                          bgColor: AppColors.bgCard,
                          borderRadius: 15,
                        )
                      );
                    },
                  ),
                ],
              ),
            )
           ],
        ),
      )
    );
  }
}