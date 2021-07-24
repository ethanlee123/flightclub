import 'package:flutter/material.dart';

import './pages/loading.dart';
import './pages/home.dart';
import './pages/login.dart';
import './pages/signup.dart';
import './pages/checkout.dart';
import './pages/edit_profile.dart';
import './pages/checkout_summary.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/login': (context) => Login(),
      '/signup': (context) => SignUp(),
      '/checkout': (context) => Checkout(),
      '/editprofile': (context) => EditProfile(),
      '/checkoutsummary': (context) => CheckoutSummary(),
    },
  ));
}

