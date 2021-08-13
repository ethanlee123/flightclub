import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product_data.dart';
import '../../../blocs/cart_bloc.dart';
import '../../../blocs/product_bloc.dart';

class ProductCard extends StatefulWidget {
  final ProductData productData;

  ProductCard({
    Key? key,
    required this.productData,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartBloc>(context);
    final productBloc = Provider.of<ProductBloc>(context);
    ThemeData themeData = Theme.of(context);

    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: themeData.primaryColor.withOpacity(0.5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(4, 3),
              )
            ]),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: '${ProductData.count + widget.productData.hashCode}',
                  child: Image.asset(
                    widget.productData.image,
                    height: constraints.maxHeight * 0.4,
                  ),
                ),
                SizedBox(height: 10),
                Text(widget.productData.name,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.accentTextTheme.headline6),
                Expanded(
                  child: Text(
                    widget.productData.description,
                    overflow: TextOverflow.fade,
                    style: themeData.accentTextTheme.subtitle1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${widget.productData.price}',
                        style: themeData.accentTextTheme.headline6),
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: cart.cartContains(widget.productData)
                            ? themeData.backgroundColor
                            : themeData.accentColor,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: themeData.accentColor, width: 1),
                      ),
                      child: IconButton(
                          padding: EdgeInsets.all(1.0),
                          color: cart.cartContains(widget.productData)
                              ? themeData.accentColor
                              : Colors.white,
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _onPressAdd(cart, productBloc);
                          }),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onPressAdd(CartBloc cart, ProductBloc productBloc) {
    cart.cartContains(widget.productData)
      ? cart.removeFromCart(widget.productData)
      : cart.addToCart(widget.productData);
  }
}
