import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerMapRepository {
    
  /// Gets user current location and returns a CameraPosition
  static Future<CameraPosition> getInitialCameraPosition() async {
    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16, 
    );
  }

    //get location changes
    getLocationChanges() {}

}