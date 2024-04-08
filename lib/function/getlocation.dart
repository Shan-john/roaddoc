import 'dart:async';
import 'package:geolocator/geolocator.dart';

Future<Position> getlocation() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return position;
}
 