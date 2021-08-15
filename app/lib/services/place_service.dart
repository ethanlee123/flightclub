import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

import '../models/place_search.dart';
import '../models/place_details_result.dart';

class PlaceService {
  final dynamic mapsKey = dotenv.env['MAPS_API_KEY'];

  // Places Autocomplete API
  Future<List<PlaceSearch>> getAutoComplete(String search, Position currentLocation) async {
    String url =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&location=${currentLocation.latitude},${currentLocation.longitude}&radius=500&key=$mapsKey';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  // Places Detail API
  Future<PlaceDetailsResult> getPlaceDetails(String placeId) async {
    String url =
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapsKey';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return PlaceDetailsResult.fromJson(jsonResult);
  }
}
