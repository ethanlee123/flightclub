import 'package:flightclub/models/place_details_geometry.dart';
import 'package:flightclub/utils/remove_last_word.dart';

class PlaceDetailsResult {
  final PlaceDetailsGeometry geometry;
  final String formattedAddress;
  final String vicinity;

  PlaceDetailsResult(
      {required this.geometry,
      required this.formattedAddress,
      required this.vicinity});

  factory PlaceDetailsResult.fromJson(Map<String, dynamic> parsedJson) {
    return PlaceDetailsResult(
        geometry: PlaceDetailsGeometry.fromJson(parsedJson['geometry']),
        formattedAddress: RemoveLastWord.removeLastWord(parsedJson['formatted_address']),
        vicinity: parsedJson['vicinity']);
  }
}
