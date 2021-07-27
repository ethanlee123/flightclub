import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'warehouse_location.dart';

class WarehouseLocations {
    List<WarehouseLocation> locations = [
        WarehouseLocation(lat: 49.1876, lng: -122.8583, id: 0),
        WarehouseLocation(lat: 49.1934, lng: -122.8599, id: 1),
        WarehouseLocation(lat: 49.1844, lng: -122.8488, id: 3),
    ];


    // addMarkers(List<LatLng> listOfLocations) {
    //     listOfLocations.map((loc) => Marker(markerId: null));
    // }
}