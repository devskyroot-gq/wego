import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/trip_functions.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/data/repositories/passenger_map_repository.dart';
import 'package:demo_pss/data/repositories/trip_repository.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/passenger_notification_page.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/passenger_post_page_detail.dart';
import 'package:demo_pss/features/auth/presentation/widgets/activity_card.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/home_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePagePassenger extends StatefulWidget {
  const HomePagePassenger({super.key});

  @override
  State<HomePagePassenger> createState() => _HomePagePassengerState();
}


class _HomePagePassengerState extends State<HomePagePassenger> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final tripRepository = Get.find<TripRepository>();
  final mapFunction = Get.find<PassengerMapRepository>();
  //trip functions
  final tripFunctions = Get.find<TripFunctions>();

  @override
  void initState() {
    super.initState();
    tripRepository.getUserTrips(authService.value.currentUser!.uid,);
  }

  @override
  void dispose() {
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
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => PassengerNotificationPage(), transition: Transition.rightToLeft, duration: Duration(milliseconds: 300));
                },
                icon: Icon(Icons.notifications),
                color: AppColors.textPrimary2,
                iconSize: 30,
                splashRadius: 20,
                padding: EdgeInsets.all(8),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.textError,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 15, minHeight: 15),
                  child: Text(
                    "1",
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
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
              child: AppLargeText(
                size: 18,
                text: "Mis proximos viajes",
                color: AppColors.textPrimary2,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: StreamBuilder(
                  stream: tripRepository.getUserTrips(
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
                        final trip =
                            trips[index].data() as Map<String, dynamic>;
                        return InkWell(
                          onTap: () async {
                            await Get.to(
                              () => PassengerPostPageDetail(),
                              arguments: trip,
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
                                            trip["id"],
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
                            username: trip["user"] ?? "Nombre",
                            location: "Ub: ${trip["sourceLabel"]}",
                            destination: "Des: ${trip["destinationLabel"]}",
                            timeAgo: tripFunctions.timeAgo(trip["createdAt"]),
                            icon: Icons.timer_rounded,
                            bgColor: AppColors.bgCard,
                            borderRadius: 15,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
