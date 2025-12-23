import 'package:demo_pss/core/theme/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationRequest{
  
   // Check & request permissions (location when in use)
  Future<bool> handleLocationPermission() async {
    // Check permission_handler for fine-grained control
    final status = await Permission.locationWhenInUse.status;
    if (status.isGranted) return true;

    final result = await Permission.locationWhenInUse.request();
    if (result.isGranted) return true;

    // If permanently denied, open app settings
    if (result.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  

}