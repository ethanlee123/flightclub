import 'package:flutter/material.dart';

import '../../models/product_data.dart';

class ProductCard extends StatefulWidget {
  final ProductData item;

  ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
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
                  tag: widget.item.hashCode,
                  child: Image.asset(
                    widget.item.image,
                    height: constraints.maxHeight * 0.4,
                  ),
                ),
                SizedBox(height: 10),
                Text(widget.item.name,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.accentTextTheme.headline6),
                Expanded(
                  child: Text(
                    widget.item.description,
                    overflow: TextOverflow.fade,
                    style: themeData.accentTextTheme.subtitle1,
                  ),
                ),
                // Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${widget.item.price}',
                        style: themeData.accentTextTheme.headline6),
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: addedToCart
                            ? themeData.backgroundColor
                            : themeData.accentColor,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: themeData.accentColor, width: 1),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(1.0),
                        color:
                            addedToCart ? themeData.accentColor : Colors.white,
                        icon: Icon(Icons.add),
                        onPressed: _addProductToCart,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _addProductToCart() {
    setState(() {
      addedToCart = !addedToCart;
    });
  }
}
