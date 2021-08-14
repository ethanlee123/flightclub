import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './custom_theme.dart';

import 'blocs/map_bloc.dart';
import 'blocs/cart_bloc.dart';
import 'blocs/product_bloc.dart';
import 'route_generator.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MapBloc()),
        ChangeNotifierProvider(create: (context) => ProductBloc()),
        ChangeNotifierProvider(create: (context) => CartBloc()),

      ],
        child: MaterialApp(

        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,

          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: currentTheme.currentTheme,
        ),

    );
  }
}
