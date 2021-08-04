import 'dart:async';
import 'dart:math';

import 'package:flightclub/models/place_details_result.dart';
import 'package:flightclub/models/place_search.dart';
import 'package:flightclub/models/warehouse._locations.dart';
import 'package:flightclub/services/place_service.dart';
import 'package:flightclub/utils/geocoord_distance.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/geolocator_service.dart';

class MapBloc with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placeService = PlaceService();

  late Position currentLocation;
  bool loaded = false;
  bool prioritizeCurrentLoc = true;
  List<PlaceSearch> searchResults = [];

  StreamController<PlaceDetailsResult> selectedLocation = StreamController<PlaceDetailsResult>.broadcast();

  List<double> distancesToWarehouse = [];

  MapBloc() {
    setCurrentLocation();
  }

  // Get current location of user and set variable currentLocation
  void setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    loaded = true;
    notifyListeners();
  }

  void changePriority() {
    prioritizeCurrentLoc = false;
  }

  void searchPlaces(String searchTerm) async {
    searchResults = await placeService.getAutoComplete(searchTerm, this.currentLocation);
    notifyListeners();
  }

  void setSelectedLocation(String placeId) async {
    selectedLocation.add(await placeService.getPlaceDetails(placeId));
    // When a search result is tapped, lear the list so search results on home page are hidden
    searchResults.clear();
    notifyListeners();
  }

  // Calculates the distance of the nearest warehouse in meters.
  // If list distancesToWarehouse in empty, return -1, otherwise return smallest value.
  double getDistNearestWarehouse(double destLat, double destLng) {
    // Set destination coordinates
    GeoCoordDistance dist = GeoCoordDistance(destLat, destLng);
    WarehouseLocations warehouseLocations = WarehouseLocations();
    double getDistanceInMeters;

    distancesToWarehouse.clear();

    // Calculate distances to warehouses
    warehouseLocations.locations.forEach((warehouse) {
      double distance = dist.getDistanceInMeters(warehouse.lat, warehouse.lng);
      distancesToWarehouse.add(distance);
    });

    if(distancesToWarehouse.length >= 1) {
      getDistanceInMeters = distancesToWarehouse.reduce(min);
      return getDistanceInMeters;
    }
    return -1;
  }

  // Calculates distance of nearest warehouse using helper method.
  // if list distancesToWarehouse is empty, return -1, otherwise return index of smallest value.
  int getIndexOfNearestWarehouse(double destLat, double destLng) {
    double distance = getDistNearestWarehouse(destLat, destLng);
    int index = distancesToWarehouse.indexOf(distance);
    return index;
  }

  // @override
  // void dispose() {
  //   selectedLocation.close();
  //   super.dispose();
  // }
}
