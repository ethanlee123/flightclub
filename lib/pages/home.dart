import 'dart:async';
import 'package:flightclub/blocs/map_bloc.dart';
import 'package:flightclub/models/place_details_result.dart';
import 'package:flightclub/models/warehouse._locations.dart';
import 'package:flightclub/pages/components/bottom_drawer.dart';
import 'package:flightclub/utils/geocoord_distance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'components/bottom_nav_bar.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  late Marker dropOffMarker;

  // Controll camera view
  Completer<GoogleMapController> _googleMapController = Completer();

  // Acting as our primary warehouse
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(49.1876, -122.8583),
    zoom: 14,
  );

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoords = [];
  PolylinePoints polylinePoints = PolylinePoints();
  WarehouseLocations warehouseLocations = WarehouseLocations();

  static bool showBottomMenu = false;
  int threshold = 200;

  static bool showSearchResults = true;
  late StreamSubscription locationSubscription;

  @override
  void initState() {
    final mapBloc = Provider.of<MapBloc>(context, listen: false);
    locationSubscription = mapBloc.selectedLocation.stream.listen((place) {
      _cameraToPlace(place);
    });
    super.initState();
  }

  @override
  void dispose() {
    final mapBloc = Provider.of<MapBloc>(context, listen: false);
    mapBloc.dispose();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = Provider.of<MapBloc>(context);

    // print(mapBloc.loaded);
    // GeoCoordDistance geoCoordDist = GeoCoordDistance(
    //     mapBloc.currentLocation.latitude,
    //     mapBloc.currentLocation.longitude,
    //     49.1876,
    //     -122.8583);
    Set<Circle> warehouseLocationCircles = Set.from([
      Circle(
        circleId: CircleId("wh"),
        center: LatLng(49.1876, -122.8583),
        radius: 80,
        fillColor: Color.fromRGBO(0, 139, 252, 0.2),
        strokeColor: Colors.transparent,
      ),
    ]);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: "Find an address",
                    suffixIcon: Icon(Icons.search),
                  ),
                  onTap: () => showSearchResults = true,
                  onChanged: (value) => {mapBloc.searchPlaces(value)},
                  onEditingComplete: () => {
                    showSearchResults = false,
                    FocusScope.of(context).unfocus(),
                  },
                ),
                (mapBloc.loaded)
                    ? Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              //   height: 300,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: _initialCameraPosition,
                                zoomControlsEnabled: false,
                                myLocationEnabled: true,
                                markers: {
                                  Marker(
                                    position: LatLng(
                                        warehouseLocations.locations[0].lat,
                                        warehouseLocations.locations[0].lng),
                                    markerId: MarkerId('warehouse 0'),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueGreen),
                                  ),
                                  Marker(
                                    position: LatLng(
                                        warehouseLocations.locations[1].lat,
                                        warehouseLocations.locations[1].lng),
                                    markerId: MarkerId('warehouse 1'),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueGreen),
                                  ),
                                  Marker(
                                    position: LatLng(
                                        warehouseLocations.locations[2].lat,
                                        warehouseLocations.locations[2].lng),
                                    markerId: MarkerId('warehouse 2'),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueGreen),
                                  ),
                                  if (mapBloc.prioritizeCurrentLoc)
                                    Marker(
                                      position: LatLng(
                                          mapBloc.currentLocation.latitude,
                                          mapBloc.currentLocation.longitude),
                                      markerId: MarkerId('warehouse 0'),
                                    )
                                  else
                                    (dropOffMarker),
                                },
                                // Circle/Radius around warehouse locations
                                circles: warehouseLocationCircles,
                                onLongPress: (position) => {
                                  _changeMarker(position),
                                  mapBloc.changePriority(),
                                  _setPolylines(
                                      position.latitude, position.longitude),
                                },
                                onMapCreated:
                                    (GoogleMapController controller) => {
                                  _assignControllers(controller),
                                  _setPolylines(
                                      mapBloc.currentLocation.latitude,
                                      mapBloc.currentLocation.longitude),
                                },
                                polylines: _polylines,
                              ),
                            ),
                            if (mapBloc.searchResults.length != 0 &&
                                showSearchResults)
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 2,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  backgroundBlendMode: BlendMode.darken,
                                ),
                              ),
                            if (mapBloc.searchResults.length != 0 &&
                                showSearchResults)
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 2,
                                child: ListView.builder(
                                  itemCount: mapBloc.searchResults.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        mapBloc
                                            .searchResults[index].description,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {_onTapSearchResult(mapBloc, index);},
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
            Positioned(
              left: 0,
              bottom: (showBottomMenu
                  ? 0
                  : -(MediaQuery.of(context).size.height / 5)),
              child: GestureDetector(
                  onPanEnd: (details) {
                    // debugPrint(details.velocity.pixelsPerSecond.dy.toString());
                    if (details.velocity.pixelsPerSecond.dy > threshold) {
                      setState(() {
                        showBottomMenu = false;
                      });
                    } else if (details.velocity.pixelsPerSecond.dy <
                        -threshold) {
                      setState(() {
                        showBottomMenu = true;
                      });
                    }
                  },
                  child: BottomDrawer()),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void _assignControllers(GoogleMapController controller) {
    _googleMapController.complete(controller);
  }

  Future<void> _cameraToLocation(double lat, double lng) async {
    final GoogleMapController controller = await _googleMapController.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 14,
        ),
      ),
    );
  }

  Future<void> _cameraToPlace(PlaceDetailsResult place) async {
    final GoogleMapController controller = await _googleMapController.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
          zoom: 14,
        ),
      ),
    );
  }

  void _changeMarker(LatLng pos) {
    setState(() {
      dropOffMarker = Marker(
        markerId: MarkerId("dropOff"),
        position: pos,
      );
    });
  }

  Future<void> _setPolylines(double destLat, double destLng) async {
    List<double> distances = [];
    GeoCoordDistance dist = GeoCoordDistance(destLat, destLng);

    // Calculate distances to warehouses
    warehouseLocations.locations.forEach((warehouse) {
      double distance = dist.getDistanceInMeters(warehouse.lat, warehouse.lng);
      distances.add(distance);
    });

    // Find index of shortest distance
    int index = distances.indexOf(distances.reduce(min));

    polylineCoords.clear();
    polylineCoords.add(LatLng(warehouseLocations.locations[index].lat,
        warehouseLocations.locations[index].lng));
    polylineCoords.add(LatLng(destLat, destLng));

    setState(() {
      _polylines.add(
        Polyline(
          width: 2,
          polylineId: PolylineId('route'),
          color: Colors.black,
          points: polylineCoords,
        ),
      );
    });

    // Move camera to new position
    _cameraToLocation(warehouseLocations.locations[index].lat,
        warehouseLocations.locations[index].lng);
  }

  void closeBottomMenu() {
    showBottomMenu = false;
  }

  void _onTapSearchResult(MapBloc mapBloc, int index) {
    mapBloc.setSelectedLocation(mapBloc.searchResults[index].placeId);
  }
}
