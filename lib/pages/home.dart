import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(49.1876, -122.8583),
    zoom: 11.5,
  );

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "search"),
          ),
          Container(
            height: 300,
            child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                zoomControlsEnabled: false),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: 0,
        // onTap: (index) => print(index)),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
        ],
      ),
    );
  }
}
