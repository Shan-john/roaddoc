import 'dart:async';

import 'package:geolocator/geolocator.dart';

Future<Position> getlocation() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return position;
}
//  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
//     <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

// <key>NSLocationWhenInUseUsageDescription</key>
//   <string>This app needs access to location when open.</string>
