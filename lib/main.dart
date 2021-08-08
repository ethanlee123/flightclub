import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './pages/loading.dart';
import './pages/walkthrough.dart';
import './pages/home.dart';
import './pages/login.dart';
import './pages/signup.dart';
import './pages/checkout.dart';
import './pages/edit_profile.dart';
import './pages/profile.dart';
import './pages/checkout_summary.dart';
import 'browse_products/browse_products.dart';

import './custom_theme.dart';
import 'blocs/map_bloc.dart';

Future main() async {
  await dotenv.load();

  // Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(FlightClub());
}

class FlightClub extends StatefulWidget {
  const FlightClub({Key? key}) : super(key: key);

  @override
  _FlightClubState createState() => _FlightClubState();
}

class _FlightClubState extends State<FlightClub> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Check theme, works with notifyListeners() in custom_theme.dart
    // currentTheme.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapBloc(),
      child: MaterialApp(
        initialRoute: '/home',
        routes: {
          '/': (context) => Loading(),
          '/walkthrough': (context) => Walkthrough(),
          '/home': (context) => Home(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/checkout': (context) => Checkout(),
          '/browseproducts': (context) => BrowseProducts(),
          '/profile': (context) => Profile(),
          '/editprofile': (context) => EditProfile(),
          '/checkoutsummary': (context) => CheckoutSummary(),
        },
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        themeMode: currentTheme.currentTheme,
      ),
    );
  }
}
