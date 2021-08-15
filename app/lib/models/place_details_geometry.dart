import './place_details_location.dart';

class PlaceDetailsGeometry {
  // Contains lat and lng
  final PlaceDetailsLocation location;

  PlaceDetailsGeometry({required this.location});

  factory PlaceDetailsGeometry.fromJson(Map<dynamic, dynamic> parsedJson) {
    return PlaceDetailsGeometry(
        location: PlaceDetailsLocation.fromJson(parsedJson['location']));
  }
}
