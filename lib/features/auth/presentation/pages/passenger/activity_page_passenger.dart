import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/trip_functions.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/data/repositories/passenger_map_repository.dart';
import 'package:demo_pss/data/repositories/trip_repository.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/passenger_post_page_detail.dart';
import 'package:demo_pss/features/auth/presentation/widgets/activity_card.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(left: 20,top: 20,right: 20),
        child: Column(
           children: [
            Container(
              child: TabBar(
                controller: tabController,
                indicatorColor: AppColors.primary,
                dividerColor: AppColors.bgCard,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textPrimary2,
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
                  StreamBuilder(
                    stream: tripRepository.getPendingTrips(
                        authService.value.currentUser!.uid,
                      ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        print("Error al cargar los datos: ${snapshot.error}");
                        return Center(child: Text("Error al cargar los datos"));
                      }
                      final trips = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: trips.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          //get every single trip
                          final $trip = trips[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () async {
                              await Get.to(
                                () => PassengerPostPageDetail(),
                                arguments: $trip,
                                transition: Transition.rightToLeft,
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text("Eliminar viaje"),
                                      content: Text(
                                        "¿Estas seguro de eliminar este viaje?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancelar"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            tripRepository.deleteTripById(
                                              $trip["id"],
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text("Eliminar"),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            child: ActivityCard(
                              width: double.maxFinite,
                              username: $trip["user"],
                              location: "Ub: ${$trip["sourceLabel"] ?? "N/A"}",
                              destination: "Des: ${$trip["destinationLabel"] ?? "N/A"}",
                              timeAgo: tripFunctions.timeAgo($trip["createdAt"]),
                              icon: Icons.access_time_filled,
                              bgColor: AppColors.bgCard,
                              borderRadius: 15,
                            )
                          );
                        },
                      );
                    }
                  ),
                  StreamBuilder(
                    stream: tripRepository.getFinishedTrips(
                        authService.value.currentUser!.uid,
                      ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        print("Error al cargar los datos: ${snapshot.error}");
                        return Center(child: Text("Error al cargar los datos"));
                      }
                      final trips = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: trips.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          //get every single trip
                          final $trip = trips[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () async {
                              await Get.to(
                                () => PassengerPostPageDetail(),
                                arguments: $trip,
                                transition: Transition.rightToLeft,
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text("Eliminar viaje"),
                                      content: Text(
                                        "¿Estas seguro de eliminar este viaje?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancelar"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            tripRepository.deleteTripById(
                                              $trip["id"],
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text("Eliminar"),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            child: ActivityCard(
                              width: double.maxFinite,
                              username: $trip["user"],
                              location: "Ub: ${$trip["sourceLabel"] ?? "N/A"}",
                              destination: "Des: ${$trip["destinationLabel"] ?? "N/A"}",
                              timeAgo: tripFunctions.timeAgo($trip["createdAt"]),
                              icon: Icons.check_circle,
                              bgColor: AppColors.bgCard,
                              borderRadius: 15,
                            )
                          );
                        },
                      );
                    }
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