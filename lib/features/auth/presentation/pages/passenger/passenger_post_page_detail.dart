
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/trip_functions.dart';
import 'package:demo_pss/data/repositories/passenger_map_repository.dart';
import 'package:demo_pss/data/repositories/trip_repository.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerPostPageDetail extends StatefulWidget {
  // final String? img;
  // final String? username;
  // final String? location;
  const PassengerPostPageDetail({super.key});

  @override
  State<PassengerPostPageDetail> createState() => _PassengerPostPageDetailState();
}

class _PassengerPostPageDetailState extends State<PassengerPostPageDetail> {
  //get arguments
  final tripArgs = Get.arguments;
  //trip functions
  final tripFunctions = Get.find<TripFunctions>();
  final mapFunctions = Get.find<PassengerMapRepository>();
  final tripRepository = Get.find<TripRepository>();
  //google map vars
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  //TODO obtimization


  @override
  void initState() {
    super.initState();
    mapFunctions.getRoutePoints(tripArgs['source'], tripArgs['destination']);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //_showBottomSheet();
    });
  }
  
  @override
  void reassemble() {
    super.reassemble();
    mapFunctions.getRoutePoints(tripArgs['source'], tripArgs['destination']);
  }

  @override
  void dispose() {
    super.dispose();
  }


   void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15)
                    ),
                    border: Border.all(color: AppColors.bgCard)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(tripArgs["img"] ?? "assets/images/user.png"),
                        ),
                      ),
                      SizedBox(width: 10,),
                      //TODO wrap text
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLargeText(
                              size: 16,
                              text: tripArgs["user"] ?? "N/A",
                              color: AppColors.textPrimary2,
                            ),
                            AppLargeText(
                              size: 12,
                              text: "Ub: ${tripArgs["sourceLabel"] ?? "N/A"}",
                              color: AppColors.textSecondary,
                            ),
                            AppLargeText(
                              size: 12,
                              text: "Des: ${tripArgs["destinationLabel"] ?? "N/A"}",
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                AppLargeText(
                  size: 20,
                  text: "Tipo de solicitud de viaje",
                  color: AppColors.textPrimary2,
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: tripArgs["tripType"] == "Now" ? AppColors.primary : Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.front_hand_outlined,
                              color: AppColors.background,
                              size: 40,
                            ),
                          ),
                          AppLargeText(
                            size: 16,
                            text: "Ahora",
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: tripArgs["tripType"] == "Today" ? AppColors.primary : Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.timer,
                              color: AppColors.background,
                              size: 40,
                            ),
                          ),
                          AppLargeText(
                            size: 16,
                            text: "Hoy",
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: tripArgs["tripType"] == "Future" ? AppColors.primary : Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.calendar_month,
                              color: AppColors.background,
                              size: 40,
                            ),
                          ),
                          AppLargeText(
                            size: 16,
                            text: "Programado",
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(8),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(15)
                      //   ),
                      //   border: Border.all(color: AppColors.bgCard)
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(
                            size: 16,
                            text: "Sobre el viaje",
                            color: AppColors.textPrimary2,
                          ),
                          Text("Distancia: ${mapFunctions.distance} km"),
                          Text("Tiempo de viaje: ${mapFunctions.duration} min"),
                          Text("Publicado: ${tripFunctions.timeAgo(tripArgs["createdAt"])}"),
                          Text("Recogida: ${tripArgs["tripTime"] ?? "N/A"}"),
                          Text("Precio: ${tripArgs["ableToPay"]} XAF")
                        ]
                      ),
                    )
                    // AppLargeText(
                    //   size: 16,
                    //   text: tripFunctions.timeAgo(tripArgs["createdAt"]),
                    //   color: AppColors.textPrimary2,
                    // ),
                    // tripArgs["tripType"] != "Now" ? AppLargeText(
                    //   size: 16,
                    //   text: "Recogida: ${tripArgs["tripTime"] ?? "N/A"}",
                    //   color: AppColors.textPrimary2,
                    // ) : SizedBox(),
                    // SizedBox(height: 10),
                    // AppLargeText(
                    //   size: 16,
                    //   text: "${tripArgs["ableToPay"]} XAF",
                    //   color: AppColors.textSuccess,
                    // ),
                  ],
                ),
                tripArgs["driverConfirmation"] == false
                    ? Center(
                  child: InkWell(
                    onTap: () {},
                    child: AppButton(
                      text: "Cancelar",
                      isIcon: false,
                      color: AppColors.textPrimaryDark,
                      bgColor: Colors.red,
                      width: double.maxFinite,
                      borderRadius: 15,
                    ),
                  ),
                ) : Center(
                  child: InkWell(
                    onTap: () {},
                    child: AppButton(
                      text: "Aceptar",
                      isIcon: false,
                      color: AppColors.textPrimaryDark,
                      bgColor: AppColors.primary,
                      width: double.maxFinite,
                      borderRadius: 15,
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        );
      },
      showDragHandle: true,
      backgroundColor: AppColors.background,
      enableDrag: true,
      isDismissible: false,
      isScrollControlled: true,
    );
  }

 // This function processes the data from Firebase
  Future<void> _updateMapData() async {
    GeoPoint source = tripArgs['source'];
    GeoPoint destination = tripArgs['destination'];

    // 2. Generate Route
    final routePoints = await mapFunctions.getRoutePoints(source, destination);

    if (mounted) {
      setState(() {
        _markers = {
          Marker(
            markerId: const MarkerId('p'), 
            position: mapFunctions.geoPointToLatLng(source), 
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: tripArgs["sourceLabel"] ?? "N/A",
              snippet: "Origen",
            ),
          ),
          Marker(
            markerId: const MarkerId('d'), 
            position: mapFunctions.geoPointToLatLng(destination), 
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: tripArgs["destinationLabel"] ?? "N/A",
              snippet: "Destino",
            ),
          ),
        };
        _polylines = {
          Polyline(
            polylineId: PolylineId("route"),
            points: routePoints,
            color: Colors.blueAccent,
            width: 6,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
          ),
        };
      });

      // 3. Zoom Camera
      _controller?.animateCamera(
        CameraUpdate.newLatLngBounds(mapFunctions.getBounds(source, destination), 80),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 70), 
        child: CustomAppBar(
          title: "Detalle",
          actionbar: IconButton(
            onPressed: () {
              _showBottomSheet();
            }, 
            icon: Icon(Icons.info_outline)
          ),
        ),
      ),
      body: StreamBuilder(
        stream: tripRepository.tripsStream,
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) return const Center(child: CircularProgressIndicator());
          _updateMapData();
          return GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(tripArgs["source"].latitude, tripArgs["source"].longitude), zoom: 80),
            onMapCreated: (mapController) => _controller = mapController,
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
          );
        }
      ),
    );
  }


}
