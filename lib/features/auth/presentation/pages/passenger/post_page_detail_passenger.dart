import 'dart:async';

import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/features/auth/presentation/pages/main_page.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/post_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/post_body.dart';
import 'package:demo_pss/features/auth/presentation/widgets/detail_bottom_sheet.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostPageDetail extends StatefulWidget {
  final String img;
  final String username;
  final String location;
  const PostPageDetail({super.key, this.img="assets/images/user.png", required this.username, required this.location});

  @override
  State<PostPageDetail> createState() => _PostPageDetailState();
}

class _PostPageDetailState extends State<PostPageDetail> {

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet();
    });
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
                        backgroundImage: AssetImage(widget.img),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(
                            size: 16,
                            text: widget.username,
                            color: Colors.black54,
                          ),
                          AppLargeText(
                            size: 14,
                            text: "Destino: ${widget.location}",
                            color: Colors.grey,
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
                    color: Colors.black54,
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
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.front_hand_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          AppLargeText(
                            size: 16,
                            text: "Ahora",
                            color: Colors.grey,
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
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          AppLargeText(
                            size: 16,
                            text: "Hoy",
                            color: Colors.grey,
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
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          AppLargeText(
                            size: 16,
                            text: "Programado",
                            color: Colors.grey,
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
                          text: "Ahora",
                          color: Colors.black54,
                        ),
                        AppLargeText(
                          size: 16,
                          text: "1000XAF",
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: AppButton(
                      text: "Aceptar",
                      isIcon: false,
                      color: AppColors.primaryDark,
                      bgColor: Colors.blue,
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
      backgroundColor: Colors.white,
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
        child: CustomAppBar(title: "Detalle", page: MainPage()),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if(details.delta.dy < - 10){
            _showBottomSheet();
          }
        },
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('Mostrar ubicacion'),
        icon: const Icon(Icons.location_history),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}
