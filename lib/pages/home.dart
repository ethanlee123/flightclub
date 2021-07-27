import 'dart:async';

import 'package:flightclub/blocs/map_bloc.dart';
import 'package:flightclub/models/warehouse._locations.dart';
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

  @override
  void initState() {
    super.initState();
    // polylinePoints = PolylinePoints();
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
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "search"),
            ),
            (mapBloc.loaded)
                ? Expanded(
                    child: Container(
                      height: 300,
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
                              position: LatLng(mapBloc.currentLocation.latitude,
                                  mapBloc.currentLocation.longitude),
                              markerId: MarkerId('warehouse 0'),
                            )
                          else
                            (dropOffMarker),
                        },
                        circles: warehouseLocationCircles,
                        onLongPress: (position) => {
                          _changeMarker(position),
                          mapBloc.changePriority(),
                          _setPolylines(
                              position.latitude,
                              position.longitude),
                        },
                        onMapCreated: (controller) => {
                          {_assignControllers(controller)},
                          _setPolylines(
                              mapBloc.currentLocation.latitude,
                              mapBloc.currentLocation.longitude),
                        },
                        polylines: _polylines,
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          _cameraToLocation(mapBloc.currentLocation.latitude,
              mapBloc.currentLocation.longitude);
        },
        child: Icon(Icons.center_focus_strong,
            color: Theme.of(context).backgroundColor),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void _assignControllers(controller) {
    _googleMapController.complete(controller);
    // controller = null;
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

  void _changeMarker(LatLng pos) {
    setState(() {
      dropOffMarker = Marker(
        markerId: MarkerId("dropOff"),
        position: pos,
      );
    });
  }

  void _setPolylines(double destLat, double destLng) async {
    List<double> distances = [];
    GeoCoordDistance dist = GeoCoordDistance(destLat, destLng);

    // Calcualte distances to warehouses
    warehouseLocations.locations.forEach((warehouse) {
      double distance = dist.getDistanceInMeters(warehouse.lat, warehouse.lng);
      distances.add(distance);
    });

    // Find index of shortest distance
    int index = distances.indexOf(distances.reduce(min));
    
    polylineCoords.clear();
    polylineCoords.add(LatLng(warehouseLocations.locations[index].lat, warehouseLocations.locations[index].lng));
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
  }
}
