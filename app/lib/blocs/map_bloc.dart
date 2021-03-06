import 'dart:async';
import 'dart:math';

import '../models/place_details_result.dart';
import '../models/place_search.dart';
import '../models/warehouse._locations.dart';
import '../services/place_service.dart';
import '../utils/geocoord_distance.dart';
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

  StreamController<PlaceDetailsResult?> selectedLocation =
      StreamController<PlaceDetailsResult?>.broadcast();
  PlaceDetailsResult? _placeDetails;

  List<double> _distancesToWarehouse = [];

  MapBloc() {
    setCurrentLocation();
  }

  PlaceDetailsResult? get placeDetails {
    return _placeDetails;
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
    searchResults =
        await placeService.getAutoComplete(searchTerm, this.currentLocation);
    notifyListeners();
  }

  void setSelectedLocation(String placeId) async {
    _placeDetails = await placeService.getPlaceDetails(placeId);
    selectedLocation.add(_placeDetails);
    // When a search result is tapped, lear the list so search results on home page are hidden
    searchResults.clear();
    notifyListeners();
  }

  // Calculates the distance of the nearest warehouse in meters.
  // If list distancesToWarehouse in empty, return -1, otherwise return smallest value.
  double getDistNearestWarehouse(double destLat, double destLng,
      [String unit = 'm', int roundTo = 2]) {
    // Set destination coordinates
    GeoCoordDistance dist = GeoCoordDistance(destLat, destLng);
    WarehouseLocations warehouseLocations = WarehouseLocations();
    double getDistanceInMeters;

    _distancesToWarehouse.clear();

    // Calculate distances to warehouses
    warehouseLocations.locations.forEach((warehouse) {
      double distance = dist.getDistanceInMeters(warehouse.lat, warehouse.lng);
      _distancesToWarehouse.add(distance);
    });

    if (_distancesToWarehouse.length >= 1) {
      getDistanceInMeters = _distancesToWarehouse.reduce(min);
      double rounded;
      if (unit == 'km') {
        double distInKm = getDistanceInMeters / 1000;
        rounded = double.parse((distInKm.toStringAsFixed(roundTo)));
        return rounded;
      } else {
        // if roundTo == -1, don't round. Keep decimals.
        if (roundTo == -1) {
          return getDistanceInMeters;
        }
        return double.parse((getDistanceInMeters).toStringAsFixed(roundTo));
      }
    }
    return -1;
  }

  // Calculates distance of nearest warehouse using helper method.
  // if list distancesToWarehouse is empty, return -1, otherwise return index of smallest value.
  int getIndexOfNearestWarehouse(double destLat, double destLng) {
    double distance = getDistNearestWarehouse(destLat, destLng, 'm', -1);
    int index = _distancesToWarehouse.indexOf(distance);
    return index;
  }
}
