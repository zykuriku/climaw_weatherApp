import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class Location {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    try {
      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      permission = await Geolocator.checkPermission();
      print('checking permission');
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print('requesting');
      }
    }
  }
}
