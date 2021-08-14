import 'package:flutter/material.dart';

import 'pages/browse_products/browse_products.dart';
import 'pages/map.dart';
import 'pages/Profile.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String tabItem;

  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (tabItem == 'page1') {
      child = Map();
    } else if (tabItem == 'page2') {
      child = BrowseProducts();
    } else if (tabItem == 'page3') {
      child = Profile();
    } else {
        // TODO: default error page
        child = BrowseProducts();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
