import 'package:flutter/material.dart';

import 'pages/browse_products/browse_products.dart';
import 'pages/checkout.dart';
import 'pages/checkout_summary.dart';
import 'pages/edit_profile.dart';
import 'pages/loading.dart';
import 'pages/login.dart';
import 'pages/profile.dart';
import 'pages/signup.dart';
import 'pages/walkthrough.dart';
import 'pages/Map.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Loading());
      case '/walkthrough':
        return MaterialPageRoute(builder: (_) => Walkthrough());
      case '/home':
        return MaterialPageRoute(builder: (_) => Map());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => Checkout());
      case '/browseproducts':
        return MaterialPageRoute(builder: (_) => BrowseProducts());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/editprofile':
        return MaterialPageRoute(builder: (_) => EditProfile());
      case '/checkoutsummary':
        return MaterialPageRoute(builder: (_) => CheckoutSummary());
      default: 
        // TODO: return error route for route that doesn't exist
        return MaterialPageRoute(builder: (_) => Map());
    }
  }
}
