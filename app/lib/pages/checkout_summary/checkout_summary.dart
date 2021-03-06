import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/cart_bloc.dart';

// ignore: must_be_immutable
class CheckoutSummary extends StatelessWidget {
  final data;
  CheckoutSummary({Key? key, required this.data}) : super(key: key);
  DateTime currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

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
            _buildProductsOrderedList(context, themeData),
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
      ],
    );
  }

  Widget _buildProductsOrderedList(BuildContext context, ThemeData themeData) {
    final cartBloc = Provider.of<CartBloc>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            height: 25.0,
            child: Text(cartBloc.cartItems[index].name,
                style: themeData.primaryTextTheme.subtitle2),
          );
        },
        childCount: cartBloc.cartItems.length,
      ),
    );
  }

  Widget _buildStartNewOrder(BuildContext context) {
    final cartBloc = Provider.of<CartBloc>(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () {
            cartBloc.clearCart();
            Navigator.of(context, rootNavigator: true).pushReplacementNamed('/home');
          },
          child: Text('Start new order'),
        ),
      ]),
    );
  }
}
