import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/banner.dart';
import 'components/exclusive_offers.dart';

class BrowseProducts extends StatefulWidget {
  const BrowseProducts({Key? key}) : super(key: key);

  @override
  _BrowseProductsState createState() => _BrowseProductsState();
}

class _BrowseProductsState extends State<BrowseProducts> {
  String _dropoffLocation = 'Choose Location';

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Container(
        color: themeData.backgroundColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: SvgPicture.asset('assets/images/carrot.svg'),
                height: 30.0,
                width: 30.0,
              ),

              Text('flightclub'.toUpperCase(),
                  style: themeData.accentTextTheme.headline5),
    
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      icon: Icon(Icons.location_on_rounded),
                      label: Text('$_dropoffLocation'),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: IconButton(
                          icon: Icon(Icons.shopping_cart),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //   SearchField(),
              Banners(),
              SizedBox(height: 10),
              _buildSectiontitle('Exclusive Offers', context),
              ExclusiveOffers(),
              _buildSectiontitle('Featured', context),
              ExclusiveOffers(),
              _buildSectiontitle('All', context),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectiontitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).accentTextTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
