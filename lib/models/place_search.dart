class PlaceSearch {
  final String description;
  final String placeId;

  PlaceSearch({required this.description, required this.placeId});

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
      print(json['description']);
      print(json['place_id']);
    return PlaceSearch(
      description: json['description'], placeId: json['place_id']);
  }
}
