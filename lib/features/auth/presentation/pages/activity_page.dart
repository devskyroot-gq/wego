import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/trip_functions.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/data/repositories/passenger_map_repository.dart';
import 'package:demo_pss/data/repositories/trip_repository.dart';
import 'package:demo_pss/features/auth/presentation/widgets/activity_card.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
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

class _ActivityPageState extends State<ActivityPage> with TickerProviderStateMixin {
  final tripRepository = Get.find<TripRepository>();
  final mapFunction = Get.find<PassengerMapRepository>();
  //trip functions
  final tripFunctions = Get.find<TripFunctions>();

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
              child: StreamBuilder(
                stream: tripRepository.getUserTrips(
                    authService.value.currentUser!.uid,
                  ),
                builder: (context, asyncSnapshot) {
                  return TabBarView(
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
                  );
                }
              ),
            )
           ],
        ),
      )
    );
  }
}