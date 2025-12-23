import 'dart:async';

import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/trip_functions.dart';
import 'package:demo_pss/data/repositories/passenger_map_repository.dart';
import 'package:demo_pss/features/auth/presentation/pages/main_page.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
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

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  //default camera position
  static const CameraPosition _defaultCamera =
    CameraPosition(target: LatLng(0, 0), zoom: 14.4746);
  //camera position
  CameraPosition? _cameraPosition;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet();
    });
    
  }

  @override
  void dispose() {
    super.dispose();
  }



  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    final camera = await PassengerMapRepository.getInitialCameraPosition();

    controller.animateCamera(CameraUpdate.newCameraPosition(camera));
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
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                    Padding(
                      padding: EdgeInsets.only(left: 10),
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
                            text: "Ub: ${tripArgs["locationLabel"] ?? "N/A"}",
                            color: AppColors.textSecondary,
                          ),
                          AppLargeText(
                            size: 12,
                            text: "Des: ${tripArgs["destination"] ?? "N/A"}",
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: AppLargeText(
                    size: 20,
                    text: "Tipo de solicitud de viaje",
                    color: AppColors.textPrimary2,
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppLargeText(
                          size: 16,
                          text: tripFunctions.timeAgo(tripArgs["createdAt"]),
                          color: AppColors.textPrimary2,
                        ),
                        tripArgs["tripType"] != "Now" ? AppLargeText(
                          size: 16,
                          text: "Recogida: ${tripArgs["tripTime"] ?? "N/A"}",
                          color: AppColors.textPrimary2,
                        ) : SizedBox(),
                        SizedBox(height: 10),
                        AppLargeText(
                          size: 16,
                          text: "${tripArgs["ableToPay"]} XAF",
                          color: AppColors.textSuccess,
                        ),
                      ],
                    ),
                  ),
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
                      width: 200,
                      borderRadius: 50,
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
                      width: 200,
                      borderRadius: 50,
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
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _defaultCamera,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
      ),
    );
  }


}
