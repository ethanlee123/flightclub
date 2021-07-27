import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  // Get current location of user
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
