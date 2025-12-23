import 'dart:async';

import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/loading_dialog.dart';
import 'package:demo_pss/core/utils/location_request.dart';
import 'package:demo_pss/data/models/trip_model.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/data/repositories/controller/order_taxi_controller.dart';
import 'package:demo_pss/data/repositories/trip_repository.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/main_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_form_button.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/input_form.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For formatting DateTime
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class OrderTaxiPage extends StatefulWidget {
  const OrderTaxiPage({super.key});

  @override
  State<OrderTaxiPage> createState() => _OrderTaxiPageState();
}

class _OrderTaxiPageState extends State<OrderTaxiPage> {
  final tripRepository = Get.put(TripRepository());
  final controller = Get.put(OrderTaxiController());
  //DateTime _defaultDateTime = DateTime.now();
  final DateFormat _dateTimeFormat = DateFormat('dd-MM-yyyy HH:mm');

  final _taxiFormKey = GlobalKey<FormState>();
  bool selectedNow = false;
  bool selectedToday = false;
  bool selectedFuture = false;
  bool actionInProgress = false;
  bool isFormValid = false;
  String errorMessage = "";
  String tripType = "";

  //location vars
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;
  final locationRequest = Get.put(LocationRequest());

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    controller.locationLabel.text = "Lugar sin nombrar";
    setState(() {
      controller.time.text = _dateTimeFormat.format(DateTime.now());
      selectedNow = true;
      tripType = "Now";
      selectedToday = false;
      selectedFuture = false;
      actionInProgress = false;
      isFormValid = false;
      errorMessage = "";
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

//form validation
  void _validateForm() {
    final isValid = _taxiFormKey.currentState?.validate() ?? false;
    if (isValid != isFormValid) {
      setState(() {
        isFormValid = isValid;
      });
    }
  }

  //select date picker
  Future<void> _selectDateTime(BuildContext context) async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2101),
      onConfirm: (date) {
        setState(() {
          controller.time.text = _dateTimeFormat.format(date);
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.es,
    );
  }

  //submit the form
  void _submitForm(String userName) async {
    if (_currentPosition != null) {
      final tripModel = TripModel(
        id: TripModel.createTripId().id,
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
        locationLabel: controller.locationLabel.text.trim(),
        destination: controller.destination.text.trim(),
        ableToPay: double.parse(controller.ableToPay.text),
        tripType: tripType,
        tripTime: controller.time.text.trim(),
        user: userName,
        userId: authService.value.currentUser!.uid,
        driverConfirmation: false,
        userConfirmation: false,
      );
      try {
        await tripRepository.createTrip(tripModel);
        await Future.delayed(Duration(seconds: 1));
        Get.until((route) => route.isFirst);
        MainPagePassenger.globalKey.currentState?.onTap(0);
        Get.snackbar(
          "Info",
          "",
          messageText: AppLargeText(text: "Se ha publicado tu viaje", color: AppColors.snackbarTextSuccess, size: 14,),
          colorText: AppColors.snackbarTextSuccess,
          backgroundColor: AppColors.snackbarSuccess,
          isDismissible: true,
          duration: Duration(seconds: 5),
        );
      } catch (e) {
        Get.snackbar(
          "Info",
          "",
          messageText: AppLargeText(text: "Se ha publicado tu viaje", color: AppColors.snackbarTextError, size: 14,),
          colorText: AppColors.snackbarTextError,
          backgroundColor: AppColors.snackbarError,
          isDismissible: true,
          duration: Duration(seconds: 5),
        );
      }
      controller.resetForm();
    }else{
      _getCurrentLocation();
    }

  }



  // Get one-time current location
  Future<void> _getCurrentLocation() async {
    final hasPermission = await locationRequest.handleLocationPermission();

    if (!hasPermission) {
      setState(() {});
      return;
    }

    // Check location services (GPS) enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // You might want to prompt the user to enable GPS
      Get.snackbar(
        "Info",
        "",
        messageText: AppLargeText(text: "Por favor activa tu GPS", color: AppColors.snackbarTextError, size: 16,),
        colorText: AppColors.snackbarTextError,
        backgroundColor: AppColors.snackbarError,
        isDismissible: true,
        duration: Duration(seconds: 5),
      );
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 10),
      );

      setState(() => _currentPosition = position);
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.value.userStream(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Center(child: CircularProgressIndicator());
        // }
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(title: "Pedir taxi"),
          ),
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _taxiFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: _validateForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Donde te encuentras actualmente? El nombre del barrio o referencia publica. Puede omitiro si no sabes.",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary2,
                          fontStyle: FontStyle.italic,
                          height: 0.9,
                        ),
                      ),
                      SizedBox(height: 10),
                      InputForm(
                        controller: controller.locationLabel,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Completa este campo";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.location_on),
                        keyboardType: TextInputType.text,
                        label: "Tu ubicacion actual",
                        //value: "Lugar sin nombrar",
                        focusBorderColor: AppColors.primary,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Donde quieres ir? El nombre del barrio o referencia publica.",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary2,
                          fontStyle: FontStyle.italic,
                          height: 0.9,
                        ),
                      ),
                      SizedBox(height: 10),
                      InputForm(
                        controller: controller.destination,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Completa este campo";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.directions_sharp),
                        keyboardType: TextInputType.text,
                        label: "Hacia donde vas?",
                        //value: "",
                        focusBorderColor: AppColors.primary,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Se razonable con el monto, precios muy bajos pueden hacer que ignoren tu solicitud.",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary2,
                          fontStyle: FontStyle.italic,
                          height: 0.9,
                        ),
                      ),
                      SizedBox(height: 10),
                      InputForm(
                        controller: controller.ableToPay,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Completa este campo";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.attach_money),
                        keyboardType: TextInputType.number,
                        label: "Cuanto vas a pagar?",
                        hintText: "",
                        //value: "",
                        focusBorderColor: AppColors.primary,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Para cuando es el viaje? Elija el tipo de viaje a realizar.",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary2,
                          fontStyle: FontStyle.italic,
                          height: 0.9,
                        ),
                      ),
                      SizedBox(height: 10),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedNow = !selectedNow;
                                });
                                if (selectedNow) {
                                  selectedFuture = false;
                                  selectedToday = false;
                                  tripType = "Now";
                                }
                              },
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    padding: EdgeInsets.all(5),
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color:
                                          selectedNow
                                              ? AppColors.primary
                                              : AppColors.bgCard,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: Icon(
                                      Icons.front_hand_outlined,
                                      color:
                                          selectedNow
                                              ? AppColors.background
                                              : AppColors.textSecondary,
                                      size: 40,
                                    ),
                                  ),
                                  AppLargeText(
                                    size: 14,
                                    text: "Ahora",
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedToday = !selectedToday;
                                  controller.time.text = _dateTimeFormat.format(
                                    DateTime.now(),
                                  );
                                });
                                if (selectedToday) {
                                  selectedNow = false;
                                  selectedFuture = false;
                                  tripType = "Today";
                                }
                              },
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    padding: EdgeInsets.all(5),
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color:
                                          selectedToday
                                              ? AppColors.primary
                                              : AppColors.bgCard,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: Icon(
                                      Icons.timer,
                                      color:
                                          selectedToday
                                              ? AppColors.background
                                              : AppColors.textSecondary,
                                      size: 40,
                                    ),
                                  ),
                                  AppLargeText(
                                    size: 14,
                                    text: "Hoy",
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedFuture = !selectedFuture;
                                  controller.time.text = _dateTimeFormat.format(
                                    DateTime.now(),
                                  );
                                });
                                if (selectedFuture) {
                                  selectedNow = false;
                                  selectedToday = false;
                                  tripType = "Future";
                                }
                              },
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    padding: EdgeInsets.all(5),
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color:
                                          selectedFuture
                                              ? AppColors.primary
                                              : AppColors.bgCard,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: Icon(
                                      Icons.calendar_month,
                                      color:
                                          selectedFuture
                                              ? AppColors.background
                                              : AppColors.textSecondary,
                                      size: 40,
                                    ),
                                  ),
                                  AppLargeText(
                                    size: 14,
                                    text: "Programado",
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      selectedNow
                          ? SizedBox()
                          : Text(
                            "Establezca la fecha y hora del viaje.",
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary2,
                              fontStyle: FontStyle.italic,
                              height: 0.9,
                            ),
                          ),
                      SizedBox(height: 10),
                      //TODO show trip time inthe input
                      selectedNow
                          ? SizedBox()
                          : InputForm(
                            controller: controller.time,
                            onTap: () {
                              _selectDateTime(context);
                            },
                            //prefixIcon: Icon(Icons.calendar_month),
                            keyboardType: TextInputType.datetime,
                            label: "",
                            readOnly: true,
                            //initialValue: _dateController.text,
                            focusBorderColor: AppColors.primary,
                            suffixIcon: InkWell(
                              onTap: () {
                                _selectDateTime(context);
                              },
                              child: Icon(Icons.calendar_month),
                            ),
                          ),
                      SizedBox(height: 10),
                      AppFormButton(
                        onpress: () => isFormValid
                            ? _submitForm(user?["Username"]) : null,
                        text: "Publicar",
                        color: isFormValid
                            ? AppColors.primary : AppColors.primaryShade300,
                        width: double.maxFinite,
                        textColor: AppColors.background,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
