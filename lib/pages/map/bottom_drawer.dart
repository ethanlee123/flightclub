import 'dart:async';

import 'package:flightclub/blocs/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomDrawer extends StatefulWidget {
  const BottomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  String dropoff = "";
  String eta = "";
  double distance = -1;

  late StreamSubscription locationSubscription;
  @override
  void initState() {
    final mapBloc = Provider.of<MapBloc>(context, listen: false);
    locationSubscription =
        mapBloc.selectedLocation.stream.listen((place) async {
      dropoff = place!.formattedAddress;
      distance = mapBloc.getDistNearestWarehouse(
          place.geometry.location.lat, place.geometry.location.lng, 'km', 2);
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

    double height = MediaQuery.of(context).size.height / 5;
    double width = MediaQuery.of(context).size.width;

    if (dropoff == '' && mapBloc.placeDetails != null) {
        dropoff = mapBloc.placeDetails!.formattedAddress;
    }

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      child: Container(
        color: Theme.of(context).primaryColor,
        width: width,
        height: height + 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Dropoff: $dropoff',
                style: Theme.of(context).primaryTextTheme.subtitle2,
              ),
              Text(
                'ETA: $eta',
                style: Theme.of(context).primaryTextTheme.subtitle2,
              ),
              if (distance == -1)
                Text(
                  'Find an address',
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                )
              else
                Text(
                  'Distance: $distance km',
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              SizedBox(height: 10.0),
              _buildProceedButton(context, mapBloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProceedButton(BuildContext context, MapBloc mapBloc) {
    if (mapBloc.placeDetails == null) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: null,
          child: Text('Search and Select a drop off location'),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushNamed('/browseproducts');
          },
          child: Text('Go Shopping!'),
        ),
      );
    }
  }
}
