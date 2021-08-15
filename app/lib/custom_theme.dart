import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggledTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData();
  }

  static ThemeData get darkTheme {
    return ThemeData(
      //   primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        color: Color(0xFF3C6E71), //turquoise
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      primaryColor: Color(0xFF353535), // dark grey
      accentColor: Color(0xFF3C6E71), //turquoise
      backgroundColor: Color(0xFFD9D9D9),
      primaryTextTheme: TextTheme(
        headline3: TextStyle(
          color: Colors.white,
          fontFamily: 'Caveat',
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color:  Color(0xFF3C6E71),
          fontFamily: 'Caveat',
          fontWeight: FontWeight.bold,
          fontSize: 48.0,
        
        ),
        subtitle1: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
        subtitle2: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        // bodyText1: TextStyle(
        //   color: Colors.white,
        //   fontSize: 24.0,
        // ),
        // bodyText2: TextStyle(
        //   color: Colors.white,
        //   fontSize: 16.0,
        //   fontWeight: FontWeight.bold
        // ),
        button: TextStyle(
            color: Color(0xFF3C6E71),
            fontSize: 14.0
        )
      ),
      accentTextTheme: TextTheme(
        headline3: TextStyle(
          color: Color(0xFF3C6E71),
          fontFamily: 'Caveat',
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          fontFamily: 'Caveat',
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          color: Color(0xFF3C6E71),
          fontFamily: 'Caveat',
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          color: Colors.black,
        //   fontFamily: 'Caveat',
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
        subtitle1: TextStyle( //Used in shop tab
          color: Color(0xFF353535),
          fontSize: 12.0,
        ),
        subtitle2: TextStyle( // Used in checkout summary page
            color: Color.fromRGBO(217, 217, 217, 0.5),
            fontSize: 16.0,
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(0xFF3C6E71),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 40)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(color: Color(0xFF3C6E71)),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Color(0xFF284B63),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      ),
 
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF284B63),
        selectedItemColor: Color(0xFFD9D9D9),
        unselectedLabelStyle: TextStyle(fontSize: 0),
        // unselectedIconTheme: IconThemeData(size: 36.0),
        showUnselectedLabels: false,
      ),
    );
  }
}
