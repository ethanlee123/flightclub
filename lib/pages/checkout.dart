import 'dart:async';

import 'package:flightclub/blocs/cart_bloc.dart';
import 'package:flightclub/blocs/map_bloc.dart';
import 'package:flightclub/pages/components/checkout_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'browse_products/components/product_card.dart';
import 'components/product_name.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _formKey = GlobalKey<FormState>();
  List<ProductName> productNameFields = [ProductName()];

  late String fullName;
  late String contactNumber;
  List<String> productNames = [];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartBloc>(context);

    ThemeData themeData = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeData.primaryColor,
      appBar: AppBar(
          title: Text('Checkout', style: themeData.accentTextTheme.headline4)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Text.rich(
                          TextSpan(
                            style: themeData.primaryTextTheme.subtitle2,
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.location_on_rounded,
                                    color: Colors.white),
                              ),
                              TextSpan(
                                text: 'Drop Location:',
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                          child: Container(
                            child: Consumer<MapBloc>(
                                builder: (context, mapBloc, child) {
                              return _buildDropOffLocation(mapBloc, themeData);
                            }),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          'Recipient Full Name:',
                          style: themeData.primaryTextTheme.subtitle2,
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cannot be left empty';
                            } else if (!isValidName(value)) {
                              return 'Please enter a valid name';
                            }
                            fullName = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
                        Text('Recipient Contact Number:',
                            style: themeData.primaryTextTheme.subtitle2),
                        SizedBox(height: 5.0),
                        TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cannot be left empty';
                            } else if (!isValidPhoneNumber(value)) {
                              return 'Please enter only numbers';
                            }
                            contactNumber = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                    //   _buildCartItems(context, cart),
                    // ],
                  ),
                ],
              ),
            ),
            _buildCartItems(context, cart),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildCancelConfirmButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidName(value) {
    final nameRegExp =
        new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(value);
  }

  bool isValidPhoneNumber(value) {
    final nameRegExp = new RegExp(r"^[0-9]+$");
    return nameRegExp.hasMatch(value);
  }

  Widget _buildDropOffLocation(MapBloc mapBloc, ThemeData themeData) {
    if (mapBloc.placeDetails != null) {
      return Text(
        '${mapBloc.placeDetails!.formattedAddress}',
        style: themeData.primaryTextTheme.subtitle2,
      );
    } else {
      return TextButton(
        onPressed: () {},
        child: Text('choose location'),
      );
    }
  }

  Widget _buildCartItems(BuildContext context, CartBloc cart) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 15.0),
            height: MediaQuery.of(context).size.height * 0.28,
            child: ProductCard(productData: cart.cartItems[index]));
      }, childCount: cart.cartItems.length),
    );
  }

  Widget _buildCancelConfirmButtons(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF284B63)),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 7),
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                Navigator.pushNamed(
                  context,
                  '/checkoutsummary',
                  arguments: CheckoutDetails(
                      name: fullName,
                      number: contactNumber,
                      products: productNames),
                );
              }
            },
            child: Text('Checkout'),
          ),
        ),
      ],
    );
  }
}
