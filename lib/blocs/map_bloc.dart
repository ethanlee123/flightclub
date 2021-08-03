import 'package:flightclub/models/place_search.dart';
import 'package:flightclub/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/geolocator_service.dart';

class MapBloc with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();

  late Position currentLocation;
  bool loaded = false;
  bool prioritizeCurrentLoc = true;
  List<PlaceSearch> searchResults = [];

  MapBloc() {
    setCurrentLocation();
  }

  // Get current location of user and set variable currentLocation
  void setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    loaded = true;
    // Notify UI of change
    notifyListeners();
  }

  void changePriority() {
    prioritizeCurrentLoc = false;
  }

  void searchPlaces(String searchTerm) async {
    print(searchTerm);
    searchResults = await placesService.getAutoComplete(searchTerm, this.currentLocation);
    notifyListeners();
  }
}
