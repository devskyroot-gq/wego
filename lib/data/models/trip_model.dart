import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;
  final Timestamp? createdAt;
  final double? latitude;
  final double? longitude;
  final String? locationLabel;
  final String? destination;
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

  

  const TripModel( {
    required this.id,
    this.createdAt,
    this.latitude,
    this.longitude,
    this.locationLabel,
    this.destination,
    this.ableToPay,
    this.tripType,
    this.tripTime,
    this.user,
    this.userId,
    this.img,
    this.driver,
    this.enrollment,
    this.driverConfirmation,
    this.userConfirmation
  });

  toJson() {
    return {
      "id": id,
      "createdAt": FieldValue.serverTimestamp(),
      "latitude": latitude,
      "longitude": longitude,
      "locationLabel": locationLabel,
      "destination": destination,
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
    };
  }

  //empty constructor
  factory TripModel.empty() => TripModel(
        id: '',
        latitude: 0.0,
        longitude: 0.0,
        locationLabel: '',
        destination: '',
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
      );

  //setting data from firebase to the model
  factory TripModel.fromFirebase(Map<String, dynamic> data, String documentId) {
    return TripModel(
      id: documentId,
      latitude: data["latitude"] ?? "",
      longitude: data["longitude"] ?? "",
      locationLabel: data["locationLabel"] ?? "",
      destination: data["destination"] ?? "",
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

