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
      appBarTheme: AppBarTheme(
        color: Color(0xFF3C6E71),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      // primaryColor: Color(0xFF3C6E71),
      primaryTextTheme: TextTheme(
        headline3: TextStyle(
          color: Colors.white, 
          fontFamily: 'Caveat',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
