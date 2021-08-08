import 'package:flutter/material.dart';

import 'components/checkout_details.dart';

class CheckoutSummary extends StatelessWidget {
  CheckoutSummary({Key? key}) : super(key: key);
  DateTime currentDateTime = DateTime.now();
//   Map checkoutDetails;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final checkoutDetails =
        ModalRoute.of(context)!.settings.arguments as CheckoutDetails;
    print(checkoutDetails);
    return Scaffold(
        backgroundColor: themeData.primaryColor,
        appBar: AppBar(
          title: Text("Thank you!", style: themeData.accentTextTheme.headline4),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'flightclub'.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: themeData.accentColor),
              ),
              SizedBox(height: 15.0),
              Text('Request successful!\nThank you for choosing FLIGHTCLUB.',
                  style: TextStyle(
                      fontSize: 16.0, color: themeData.backgroundColor)),
              SizedBox(height: 30.0),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Date: ',
                      style: themeData.accentTextTheme.subtitle2,
                    ),
                    TextSpan(
                      text: '$currentDateTime',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Text('Drop off contact:',
                  style: themeData.accentTextTheme.subtitle2),
              Text('${checkoutDetails.name}',
                  style: themeData.primaryTextTheme.subtitle2),
              SizedBox(height: 10.0),
              Text('${checkoutDetails.number}',
                  style: themeData.primaryTextTheme.subtitle2),
              SizedBox(height: 30.0),
              Text('Drop off location:',
                  style: themeData.accentTextTheme.subtitle2),
              Text('address to be passed from home screen',
                  style: themeData.primaryTextTheme.subtitle2),
              SizedBox(height: 30.0),
              Text('Products:', style: themeData.accentTextTheme.subtitle2),
              Text('${checkoutDetails.products.join(', ')}',
                  style: themeData.primaryTextTheme.subtitle2),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) {
                    return route.settings.name == '/home';
                  });
                },
                child: Text('Start new order'),
              ),
            ],
          ),
        ));
  }
}
