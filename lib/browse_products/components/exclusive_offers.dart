import 'package:flightclub/blocs/product_bloc.dart';

import '../../models/product_data.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ExclusiveOffers extends StatefulWidget {
  final ProductBloc productBloc;
  final String special;

  ExclusiveOffers({
    Key? key,
    required this.productBloc,
    required this.special,
  }) : super(key: key);

  @override
  _ExclusiveOffersState createState() => _ExclusiveOffersState();
}

class _ExclusiveOffersState extends State<ExclusiveOffers> {
  late final List<ProductData> _items;

  @override
  void initState() {
    setItems();
    super.initState();
  }

  void setItems() {
    switch (widget.special) {
      case 'featured':
        {
          _items = widget.productBloc.featuredProductData;
        }
        break;
      case 'exclusive':
        {
          _items = widget.productBloc.exclusiveProductData;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        itemBuilder: (_, i) => ProductCard(item: _items[i]),
        separatorBuilder: (_, __) => SizedBox(width: 10),
      ),
    );
  }
}
