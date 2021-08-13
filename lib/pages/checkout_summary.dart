import 'package:flightclub/blocs/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CheckoutSummary extends StatelessWidget {
  final data;
  CheckoutSummary({Key? key, required this.data}) : super(key: key);
  DateTime currentDateTime = DateTime.now();
//   Map checkoutDetails;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // print(data['products'])
    // final checkoutDetails =
    //     ModalRoute.of(context)!.settings.arguments as CheckoutDetails;
    // print(checkoutDetails);
    return Scaffold(
      backgroundColor: themeData.primaryColor,
      appBar: AppBar(
        title: Text("Thank you!", style: themeData.accentTextTheme.headline4),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [_buildSummaryInfo(context, themeData)],
              ),
            ),
            _buildProductsOrderedList(context),
            _buildStartNewOrder(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryInfo(BuildContext context, ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'flightclub'.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w900, color: themeData.accentColor),
        ),
        SizedBox(height: 15.0),
        Text('Request successful!\nThank you for choosing FLIGHTCLUB.',
            style: TextStyle(fontSize: 16.0, color: themeData.backgroundColor)),
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
        Text('Drop off contact:', style: themeData.accentTextTheme.subtitle2),
        Text('${data['name']}', style: themeData.primaryTextTheme.subtitle2),
        SizedBox(height: 10.0),
        Text('${data['number']}', style: themeData.primaryTextTheme.subtitle2),
        SizedBox(height: 30.0),
        Text('Drop off location:', style: themeData.accentTextTheme.subtitle2),
        Text('address to be passed from home screen',
            style: themeData.primaryTextTheme.subtitle2),
        SizedBox(height: 30.0),
        Text('Products:', style: themeData.accentTextTheme.subtitle2),
        //   _buildProductsOrderedList(context),
        //   Text('${data['products'].join(', ')}',
        //   style: themeData.primaryTextTheme.subtitle2),
        SizedBox(height: 30.0),
      ],
    );
  }

  Widget _buildProductsOrderedList(BuildContext context) {
    final cartBloc = Provider.of<CartBloc>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            height: 25.0,
            child: Text(cartBloc.cartItems[index].name),
          );
        },
        childCount: cartBloc.cartItems.length,
      ),
      //     children: cartBloc.cartItems.map((product) {
      //   return Container(height: 25.0, child: Text(product.name));
    );
  }

  Widget _buildStartNewOrder(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
          SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) {
              return route.settings.name == '/home';
            });
            Navigator.of(context).popUntil(ModalRoute.withName('/home'));
          },
          child: Text('Start new order'),
        ),
      ]),
    );
  }
}
