import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripModel {
  final String id;
  final Timestamp? createdAt;
  final GeoPoint? source;
  final String? sourceLabel;
  final GeoPoint? destination;
  final String? destinationLabel;
  final double? ableToPay;
  final String? tripType;
  final String? tripTime;
  final String? user;
  final String? userId;
  final String? img;
  final String? driver;
  final String? enrollment;
  final bool? driverConfirmation;
  final bool? userConfirmation;
  final bool? tripStarted;
  final bool? tripFinished;

  

  const TripModel( {
    required this.id,
    this.createdAt,
    this.source,
    this.sourceLabel,
    this.destination,
    this.destinationLabel,
    this.ableToPay,
    this.tripType,
    this.tripTime,
    this.user,
    this.userId,
    this.img,
    this.driver,
    this.enrollment,
    this.driverConfirmation,
    this.userConfirmation,
    this.tripStarted, 
    this.tripFinished,
  });

  toJson() {
    return {
      "id": id,
      "createdAt": FieldValue.serverTimestamp(),
      "source": source,
      "sourceLabel": sourceLabel,
      "destination": destination,
      "destinationLabel": destinationLabel,
      "ableToPay": ableToPay,
      "tripType": tripType,
      "tripTime": tripTime,
      "user": user,
      "userId": userId,
      "img": img,
      "driver": driver,
      "enrollment": enrollment,
      "driverConfirmation": driverConfirmation,
      "userConfirmation": userConfirmation,
      "tripStarted": tripStarted,
      "tripFinished": tripFinished,
    };
  }

  //empty constructor
  factory TripModel.empty() => TripModel(
        id: '',
        createdAt: null,
        source: null,
        sourceLabel: '',
        destination: null,
        destinationLabel: '',
        ableToPay: 0.0,
        tripType: '',
        tripTime: "", 
        user: '', 
        userId: '',
        img: '', 
        driver: '', 
        enrollment: '',
        driverConfirmation: false,
        userConfirmation: false,
        tripStarted: false,
        tripFinished: false,
      );

  //setting data from firebase to the model
  factory TripModel.fromFirebase(Map<String, dynamic> data, String documentId) {
    return TripModel(
      id: documentId,
      source: GeoPoint(data["source"]["latitude"], data["source"]["longitude"]),
      sourceLabel: data["locationLabel"] ?? "",
      destination: GeoPoint(data["source"]["latitude"], data["source"]["longitude"]),
      destinationLabel: data["destination"] ?? "",
      ableToPay: data["ableToPay"] ?? "",
      tripType: data["tripType"] ?? "",
      tripTime: data["tripTime"] ?? "",
      user: data["user"] ?? "",
      userId: data["userId"] ?? "",
      img: data["img"] ?? "",
      driver: data["driver"] ?? "",
      enrollment: data["enrollment"] ?? "",
      driverConfirmation: data["driverConfirmation"] ?? false,
      userConfirmation: data["userConfirmation"] ?? false,
      tripStarted: data["tripStarted"] ?? false,
      tripFinished: data["tripFinished"] ?? false,
    );
  }

  //create trip id
  factory TripModel.createTripId() {
    final day = DateTime.now().day.toString().padLeft(2, '0');
    final month = DateTime.now().month.toString().padLeft(2, '0');
    final year = DateTime.now().year.toString();
    final hour = DateTime.now().hour.toString().padLeft(2, '0');
    final minute = DateTime.now().minute.toString().padLeft(2, '0');
    final second = DateTime.now().second.toString().padLeft(2, '0');

    return TripModel(id: 'TRP$day$month$year.$hour$minute$second.${DateTime.now().millisecond}'.toString());
  }

}

