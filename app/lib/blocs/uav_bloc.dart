// Communicates with the backend uav service

import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/uav_service.dart';

class UavBloc extends ChangeNotifier {
  final uavService = UavService();

  Future executeDelivery(double lat, double lng) async {
    var response = await uavService.autonomousFlight(lat, lng);

    if (response.statusCode != 200) {
      print('Request failed with status code:  ${response.statusCode}');
    } else {
      var decoded = jsonDecode(response.body);

      print('executed test');
      print(decoded);
    }
  }
}
