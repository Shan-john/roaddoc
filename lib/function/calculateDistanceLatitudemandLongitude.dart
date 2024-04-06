import 'dart:math';

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}

double calculateDistance(LatLng start, LatLng end) {
  const R = 6371.0; // Radius of the Earth in kilometers

  final lat1 = radians(start.latitude);
  final lon1 = radians(start.longitude);
  final lat2 = radians(end.latitude);
  final lon2 = radians(end.longitude);

  final dlat = lat2 - lat1;
  final dlon = lon2 - lon1;

  final a =
      pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  final distance = R * c;
  return distance;
}

double radians(double degrees) {
  return degrees * pi / 180;
}


