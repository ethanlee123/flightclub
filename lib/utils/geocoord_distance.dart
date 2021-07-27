import 'package:geolocator/geolocator.dart';

class GeoCoordDistance {
  late double startLatitude;
  late double startLongitude;

//   late double endLatitude;
//   late double endLongitude;

  GeoCoordDistance(startLatitude, startLongitude) {
    this.startLatitude = startLatitude;
    this.startLongitude = startLongitude;
    // this.endLatitude = endLatitude;
    // this.endLongitude = endLongitude;
  }

  getDistanceInMeters(endLatitude, endLongitude) {
    double distance = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distance;
  }

}
