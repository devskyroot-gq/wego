import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uuid/uuid.dart';

class PassengerMapRepository {

  String? _sessionToken;
  final _uuid = const Uuid();
  final String apiKey = "AIzaSyA9Rn_mn5bi46qGLbAwZuaPsOZPgybXNNM";
  Position? _currentPosition;
  String url = "";
  //points
  final Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints(apiKey: 'AIzaSyA9Rn_mn5bi46qGLbAwZuaPsOZPgybXNNM');
  //
  String distance = "";
  String duration = "";


  


  //get current location
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. GPS enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    // 2. Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    // 3. Get position
    _currentPosition = await Geolocator.getCurrentPosition();
    return _currentPosition;
  }
    
  /// Gets user current location and returns a CameraPosition
  static Future<CameraPosition> getInitialCameraPosition() async {
    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: Duration(seconds: 30)
    );

    return CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16, 
    );
  }

    //get location sugestion
  Future<List<dynamic>> getPlaceSuggestions(String input) async {
    if (input.isEmpty) return [];
    url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input'
        '&components=country:gq'
        '&language=es'
        '&sessiontoken=$sessionToken'
        '&key=$apiKey';

    // If we have a current position, add near paramsto the URL
    if (_currentPosition != null) {
      url += '&location=${_currentPosition!.latitude},${_currentPosition!.longitude}'; 
      url += '&radius=15000';
    }
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      // final predictions = data['predictions'] as List;
      // return predictions.map((p) => p['description'] as String).toList();
      return json.decode(response.body)['predictions'];
    } else {
      throw Exception('Error al cargar sugerencias');
    }
  }
//get place coordinates
  Future<LatLng?> getPlaceCoords(String placeId, String sessionToken) async {
    url = 'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=geometry,name'
      '&sessiontoken=$sessionToken'
      '&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  print("Debug Response: $response");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print("Debug data: $data");
    if(data['status'] == 'OK'){
      final location = data['result']['geometry']['location'];
      final double lat = location['lat'];
      final double lng = location['lng'];
      return LatLng(lat, lng);
    }
  }
  return null;
}
//convert geopoint to latlng
LatLng geoPointToLatLng(GeoPoint geoPoint) {
  return LatLng(geoPoint.latitude, geoPoint.longitude);
}

  // Return the current token or create a new one if it doesn't exist
  String get sessionToken {
    _sessionToken ??= _uuid.v4();
    return _sessionToken!;
  }
  // Reset token when user selected a location
  void refreshSession() => _sessionToken = _uuid.v4();


  // Fetch Polyline points between two coordinates
  Future<List<LatLng>> getRoutePoints(GeoPoint source, GeoPoint destination) async {
    PolylinePoints polylinePoints = PolylinePoints(apiKey: apiKey);
    
    // Using Routes API V2
    RoutesApiResponse response = await polylinePoints.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(source.latitude, source.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
        routingPreference: RoutingPreference.trafficAwareOptimal,

      ),
    );

    if (response.routes.isNotEmpty) {
      Route route = response.routes.first;
      // Access route information
      distance = route.distanceKm!.toStringAsFixed(2);
      duration = route.durationMinutes!.toStringAsFixed(2);
      print('Duration: ${route.durationMinutes} minutes');
      print('Distance: ${route.distanceKm} km');
      return response.routes.first.polylinePoints!
          .map((p) => LatLng(p.latitude, p.longitude))
          .toList();
    }
    return [];
  }

  // Calculate bounds to fit both markers on screen
  LatLngBounds getBounds(GeoPoint source, GeoPoint destination) {
    return LatLngBounds(
      southwest: LatLng(
        source.latitude < destination.latitude ? source.latitude : destination.latitude,
        source.longitude < destination.longitude ? source.longitude : destination.longitude,
      ),
      northeast: LatLng(
        source.latitude > destination.latitude ? source.latitude : destination.latitude,
        source.longitude > destination.longitude ? source.longitude : destination.longitude,
      ),
    );
  }


//get polylines points
// void getPoints(RoutesApiRequest request, GeoPoint source, GeoPoint destination) async{
//   RoutesApiResponse response = await polylinePoints
//         .getRouteBetweenCoordinatesV2(request: request);
//     if (response.routes.isNotEmpty) {
//       Route route = response.routes.first;

//       // Access route information
//       print('Duration: ${route.durationMinutes} minutes');
//       print('Distance: ${route.distanceKm} km');

//       // Get polyline points
//       List<PointLatLng> points = route.polylinePoints ?? [];
//       for (var point in points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//         polylines.add(Polyline(
//           polylineId: PolylineId('route'),
//           points: polylineCoordinates,
//           color: Colors.red,
//           width:5,
//           visible: true,
//           startCap: Cap.roundCap,
//           endCap: Cap.roundCap,
//           geodesic: true,
//           jointType: JointType.round,
//         ));
//       // setState(() {
//       // });
//     } else {
//       print('NO ROUTE FOUND');
//       print("Source: $source");
//       print("Destination: $destination");
//     }
// }


}