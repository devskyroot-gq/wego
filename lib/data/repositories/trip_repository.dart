import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_pss/data/models/trip_model.dart';
import 'package:get/get.dart';

class TripRepository extends GetxController {
  static TripRepository get instance => Get.find();
//var to fetch stream trips in real-time
  final Stream<QuerySnapshot> tripsStream =
      FirebaseFirestore.instance.collection('Trips').snapshots();

  final db = FirebaseFirestore.instance;
  
  //create trip
  Future<void> createTrip(TripModel tripModel) async{
    try {
      db.collection("Trips").add(tripModel.toJson());
      print("Trip created successfully");
    } catch (e) {
      print("ERROR: $e");
    }
  }

  //update trip
  Future<TripModel> updateTrip(TripModel newTripModel, String tripId) async{
    try {
      final query = await  db.collection("Trips").where("id", isEqualTo: tripId).get();
      if (query.size > 0) {
        query.docs.first.reference.update(newTripModel.toJson());
        print("Trip updated successfully");
      } 
    } catch (e) {
      print("ERROR: $e");
      return TripModel.empty();
    }
    return newTripModel;
  }

//get user last 5 trips trips
Stream<QuerySnapshot> getUserTrips(String userId) {
  return db
      .collection('Trips')
      .where('userId', isEqualTo: userId)
      .orderBy("createdAt", descending: true)
      .limit(5)
      .snapshots();
}

//get all user trips
Stream<QuerySnapshot> getAllUserTrips(String userId) {
  return db
      .collection('Trips')
      .where("userId", isEqualTo: userId)
      .orderBy("createdAt", descending: true)
      .snapshots();
}

//delete trip
Future<void> deleteTripById(String tripId) async{
  await db.collection("Trips").where(
    "id",
    isEqualTo: tripId,
  ).get().then((query) {
    query.docs.first.reference.delete();
  });
  print("Trip deleted successfully");
}

}
