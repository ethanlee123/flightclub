import 'package:flutter/material.dart';

import 'pages/browse_products/browse_products.dart';
import 'pages/checkout.dart';
import 'pages/checkout_summary.dart';
import 'pages/edit_profile.dart';
import 'pages/home.dart';
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
        return MaterialPageRoute(builder: (context) => Loading());
      case '/walkthrough':
        return MaterialPageRoute(builder: (context) => Walkthrough());
      case '/home':
        return MaterialPageRoute(builder: (context) => Home());
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/signup':
        return MaterialPageRoute(builder: (context) => SignUp());
      case '/checkout':
        return MaterialPageRoute(builder: (context) => Checkout());
      case '/browseproducts':
        return MaterialPageRoute(builder: (context) => BrowseProducts());
      case '/profile':
        return MaterialPageRoute(builder: (context) => Profile());
      case '/editprofile':
        return MaterialPageRoute(builder: (context) => EditProfile());
      case '/checkoutsummary':
          return MaterialPageRoute(builder: (context) => CheckoutSummary(data: args));
      default: 
        // TODO: return error route for route that doesn't exist
        return MaterialPageRoute(builder: (context) => BrowseProducts());
    }
  }
}
