class PlaceDetailsLocation{
    final double lat;
    final double lng;

    PlaceDetailsLocation({required this.lat, required this.lng});

    factory PlaceDetailsLocation.fromJson(Map<String, dynamic> parsedJson) {
        return PlaceDetailsLocation(lat: parsedJson["lat"], lng: parsedJson["lng"]);
    }
}