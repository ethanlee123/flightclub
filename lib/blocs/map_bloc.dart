import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/geolocator_service.dart';

class MapBloc with ChangeNotifier {
  final geolocatorService = GeolocatorService();

  late Position currentLocation;
  bool loaded = false;
  bool prioritizeCurrentLoc = true;

  MapBloc() {
    setCurrentLocation();
  }

  // Get current location of user and set variable currentLocation
  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    loaded = true;
    // Notify UI of change
    notifyListeners();
  }

  void changePriority() {
    prioritizeCurrentLoc = false;
  }

}
