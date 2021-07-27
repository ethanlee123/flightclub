import 'package:geolocator/geolocator.dart';

class GeoCoordDistance {
  late double startLatitude;
  late double startLongitude;

  late double endLatitude;
  late double endLongitude;

  GeoCoordDistance(startLatitude, startLongitude, endLatitude, endLongitude) {
    this.startLatitude = startLatitude;
    this.startLongitude = startLongitude;
    this.endLatitude = endLatitude;
    this.endLongitude = endLongitude;
  }

  getDistanceInMeters() {
    double distance = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    print("DISTANCE IN METERS");
    print(distance);
    return distance;
  }

}
