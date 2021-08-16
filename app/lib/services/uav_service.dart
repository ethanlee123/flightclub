// Request delivery
import 'dart:convert';

import 'package:http/http.dart';

class UavService {
  static final Uri androidLocalHostAutoFlight =
      Uri.parse('http://10.0.2.2:5000/autoflight');

  Future autonomousFlight(double lat, double lng) async {
    String latitude = lat.toString();
    String longitude = lng.toString();

    Response response = await post(androidLocalHostAutoFlight,
        body: jsonEncode(<String, String>{'lat': latitude, 'lng': longitude}));

    return response;
  }
}
