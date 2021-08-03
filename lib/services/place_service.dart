import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flightclub/models/place_search.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlacesService {
  final dynamic mapsKey = dotenv.env['MAPS_API_KEY'];

  Future<List<PlaceSearch>> getAutoComplete(String search, Position currentLocation) async {
    String url =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&location=${currentLocation.latitude},${currentLocation.longitude}&radius=500&key=$mapsKey';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
