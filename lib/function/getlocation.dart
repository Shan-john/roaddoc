import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getlocation() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return position;
}


  Future<Placemark> getPlaceName(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    print(placemark[0].street);
    return placemark[0];
  }