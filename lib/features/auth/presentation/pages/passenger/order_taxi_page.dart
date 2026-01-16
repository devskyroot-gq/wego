import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:demo_pss/core/utils/debouncer.dart';
import 'package:demo_pss/core/utils/loading_dialog.dart';
import 'package:demo_pss/core/utils/location_request.dart';
import 'package:demo_pss/data/models/trip_model.dart';
import 'package:demo_pss/data/repositories/auth_repositories/user_repository.dart';
import 'package:demo_pss/data/repositories/controller/order_taxi_controller.dart';
import 'package:demo_pss/data/repositories/passenger_map_repository.dart';
import 'package:demo_pss/data/repositories/trip_repository.dart';
import 'package:demo_pss/features/auth/presentation/pages/passenger/main_page_passenger.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_form_button.dart';
import 'package:demo_pss/features/auth/presentation/widgets/app_large_text.dart';
import 'package:demo_pss/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:demo_pss/features/auth/presentation/widgets/input_form.dart';
import 'package:demo_pss/features/auth/presentation/widgets/money_input_form.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final _controller = Get.put(OrderTaxiController());
  final mapFunction = Get.find<PassengerMapRepository>();
  final locationRequest = Get.put(LocationRequest());
  Timer? _debouncer;
  //DateTime _defaultDateTime = DateTime.now();
  final DateFormat _dateTimeFormat = DateFormat('dd-MM-yyyy HH:mm');
  //location vars
  StreamSubscription<Position>? _positionStreamSubscription;
  //position
  Position? _currentPosition;
  //formatter
  final _formatter = CurrencyTextInputFormatter.currency(
    symbol: 'XAF',
    locale: 'es_EC',
    decimalDigits: 0,
    );

  final _taxiFormKey = GlobalKey<FormState>();
  bool selectedNow = false;
  bool selectedToday = false;
  bool selectedFuture = false;
  bool actionInProgress = false;
  bool isFormValid = false;
  String errorMessage = "";
  String tripType = "";


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _controller.sourceLabel.text = "Ubicacion de recogida";
    _controller.time.text = _dateTimeFormat.format(DateTime.now());
    selectedNow = true;
    tripType = "Now";
    selectedToday = false;
    selectedFuture = false;
    actionInProgress = false;
    isFormValid = false;
    errorMessage = "";

  }

  @override
  void dispose() {
    _debouncer?.cancel();
    _positionStreamSubscription?.cancel();
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
          _controller.time.text = _dateTimeFormat.format(date);
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
        source: _controller.source,
        sourceLabel: _controller.sourceLabel.text.trim(),
        destination: _controller.destination,
        destinationLabel: _controller.destinationLabel.text.trim(),
        ableToPay: double.parse(_formatter.getUnformattedValue().toString()),
        tripType: tripType,
        tripTime: _controller.time.text.trim(),
        user: userName,
        userId: authService.value.currentUser!.uid,
        driverConfirmation: false,
        userConfirmation: false,
        tripStarted: false,
        tripFinished: false
      );
      try {
        await tripRepository.createTrip(tripModel);
        await Future.delayed(Duration(seconds: 1));
        Get.until((route) => route.isFirst);
        MainPagePassenger.globalKey.currentState?.onTap(0);
        Get.snackbar(
          "Info",
          "",
          messageText: AppLargeText(
            text: "Se ha publicado tu viaje",
            color: AppColors.snackbarTextSuccess,
            size: 14,
          ),
          colorText: AppColors.snackbarTextSuccess,
          backgroundColor: AppColors.snackbarSuccess,
          isDismissible: true,
          duration: Duration(seconds: 5),
        );
      } catch (e) {
        Get.snackbar(
          "Info",
          "",
          messageText: AppLargeText(
            text: "Se ha publicado tu viaje",
            color: AppColors.snackbarTextError,
            size: 14,
          ),
          colorText: AppColors.snackbarTextError,
          backgroundColor: AppColors.snackbarError,
          isDismissible: true,
          duration: Duration(seconds: 5),
        );
      }
      _controller.resetForm();
    } else {
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
        messageText: AppLargeText(
          text: "Por favor activa tu GPS",
          color: AppColors.snackbarTextError,
          size: 16,
        ),
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
        timeLimit: const Duration(seconds: 30),
      );

      setState(() => _currentPosition = position);
      setState(() => _controller.source = GeoPoint(position.latitude, position.longitude));
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
                      SearchAnchor(
                        builder: (
                          BuildContext context,
                          SearchController controller,
                        ) {
                          return InputForm(
                            controller: controller,
                            onTap: () => controller.openView(),
                            onChanged: (_) => controller.openView(),
                            prefixIcon: Icon(Icons.my_location),
                            keyboardType: TextInputType.text,
                            label: "Tu ubicacion actual",
                            value: _controller.sourceLabel.text = controller.text = "Ubicacion de recogida",
                            //value: "Lugar sin nombrar",
                            focusBorderColor: AppColors.primary,
                          );
                        },
                        suggestionsBuilder: (BuildContext context,SearchController controller) async {
                          if (_debouncer?.isActive ?? false) _debouncer?.cancel(); 
                          // completer to wait API results
                          final completer = Completer<List<Widget>>();
                          _debouncer = Timer(
                            const Duration(milliseconds: 500),
                            () async {
                              //calling google maps function
                              final results = await mapFunction
                                  .getPlaceSuggestions(controller.text);
                              //creating the list
                              List<Widget> suggestionWidgets = [];
                              //adding first item to the list
                              suggestionWidgets.add(
                                ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.my_location, color: Colors.white),
                                  ),
                                  title: Text("Usar mi ubicacion actual"),
                                  subtitle: Text("Guinea Ecuatorial"),
                                  shape: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  onTap: () async{
                                    _controller.source = GeoPoint(_currentPosition!.latitude, _currentPosition!.longitude);
                                    controller.closeView("Usar mi ubicacion actual");
                                    setState((){
                                      controller.text = "Ubcacion de recogida";
                                      _controller.sourceLabel.text = "Ubcacion de recogida";
                                    });
                                    mapFunction.refreshSession();
                                  },
                              ));
                              //adding other items to the list
                              final widgets = results
                                      .map(
                                        (suggestion){
                                            // 1. Getting main text(ej: "Restaurante La Paz")
                                            final String mainText = suggestion['structured_formatting']['main_text'];
                                            
                                            // 2. Getting city and country
                                            final String secondaryText = suggestion['structured_formatting']['secondary_text'];
                                            
                                            return ListTile(
                                            leading: Icon(Icons.location_on),
                                            title: Text(mainText),
                                            subtitle: Text(secondaryText),
                                            shape: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                            onTap: () async{
                                              final placeId = suggestion['place_id'];
                                              final currentToken = mapFunction.sessionToken;
                                              //cords
                                              LatLng? locationCords = await mapFunction.getPlaceCoords(placeId, currentToken);
                                              if(locationCords != null){
                                                setState(() {
                                                  controller.text = mainText;
                                                  _controller.sourceLabel.text = mainText;
                                                });
                                                controller.closeView(suggestion['structured_formatting']['main_text']);
                                                _controller.source = GeoPoint(locationCords.latitude, locationCords.longitude);
                                                mapFunction.refreshSession();
                                              }else{
                                                setState(() {
                                                  _controller.sourceLabel.text = "Lugar de recogida";
                                                });
                                                GeoPoint geoPoint = mapFunction.getCurrentLocation() as GeoPoint;
                                                _controller.source = GeoPoint(geoPoint.latitude, geoPoint.longitude);
                                              }
                                              
                                            },
                                          );
                                        } 
                                      
                                    );
                              suggestionWidgets.addAll(widgets);
                              completer.complete(suggestionWidgets);
                            },
                          );
                          
                          return await completer.future;
                        },
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
                      SearchAnchor(
                        builder: (
                          BuildContext context,
                          SearchController controller,
                        ) {
                          return InputForm(
                            controller: controller,
                            onTap: () => controller.openView(),
                            onChanged: (_) => controller.openView(),
                            prefixIcon: Icon(Icons.location_on),
                            keyboardType: TextInputType.text,
                            label: "Hacia donde vas?",
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "Completa este campo";
                              }
                              return null;
                            },
                            focusBorderColor: AppColors.primary,
                          );
                        },
                        suggestionsBuilder: (
                          BuildContext context,
                          SearchController controller,
                        ) async {
                          if (_debouncer?.isActive ?? false) _debouncer?.cancel();
                          //completter to wait API results
                          final completer = Completer<List<Widget>>();
                          _debouncer = Timer(
                            const Duration(milliseconds: 500),
                            () async {
                              //calling google maps function
                              final results = await mapFunction
                                  .getPlaceSuggestions(controller.text);
                                  
                              final widgets =
                                  results
                                      .map(
                                        (suggestion){
                                            // 1. Getting main text(ej: "Restaurante La Paz")
                                            final String mainText = suggestion['structured_formatting']['main_text'];
                                            
                                            // 2. Geting country and city
                                            final String secondaryText = suggestion['structured_formatting']['secondary_text'];
                                            return ListTile(
                                            leading: Icon(Icons.location_on),
                                            title: Text(mainText),
                                            subtitle: Text(secondaryText),
                                            shape: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                            onTap: () async{
                                              controller.text = mainText;
                                              final placeId = suggestion['place_id'];
                                              debugPrint("Place ID: $placeId");
                                              final currentToken = mapFunction.sessionToken;
                                              debugPrint("Current Token: $currentToken");
                                              //cords
                                              LatLng? locationCords = await mapFunction.getPlaceCoords(placeId, currentToken);
                                              if(locationCords != null){
                                                setState(() {
                                                  _controller.destinationLabel.text = mainText;
                                                });
                                                _controller.destination = GeoPoint(locationCords.latitude, locationCords.longitude);
                                                controller.closeView(suggestion['structured_formatting']['main_text']);
                                                mapFunction.refreshSession();
                                              }
                                            },
                                            
                                          );
                                        } 
                                      ).toList();
                              completer.complete(widgets);
                            },
                          );
                          return await completer.future;
                        },
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
                      // InputForm(
                      //   controller: _controller.ableToPay,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Completa este campo";
                      //     }
                      //     return null;
                      //   },
                      //   prefixIcon: Icon(Icons.attach_money),
                      //   keyboardType: TextInputType.number,
                      //   label: "Cuanto vas a pagar?",
                      //   hintText: "",
                      //   //value: "",
                      //   focusBorderColor: AppColors.primary,
                      // ),
                      
                      MoneyInputForm(
                        controller: _controller.ableToPay,
                        label: "Cuanto vas a pagar?", 
                        prefixIcon: Icon(Icons.attach_money),
                        focusBorderColor: AppColors.primary,
                        inputFormatters: [_formatter],
                        value: _controller.ableToPay.text,
                        onTap: () {
                          _controller.ableToPay.text = "";
                        },
                        onChanged: (value) {
                          _controller.ableToPay.text = value;
                        },
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
                                  _controller.time.text = _dateTimeFormat
                                      .format(DateTime.now());
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
                                  _controller.time.text = _dateTimeFormat
                                      .format(DateTime.now());
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
                            controller: _controller.time,
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
                        onpress:
                            () =>
                                isFormValid
                                    ? _submitForm(user?["Username"])
                                    : null,
                        text: "Publicar",
                        color:
                            isFormValid
                                ? AppColors.primary
                                : AppColors.primaryShade300,
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
