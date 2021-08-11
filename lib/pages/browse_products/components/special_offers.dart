import 'package:flutter/material.dart';

import '../../../models/product_data.dart';
import 'product_card.dart';

class SpecialOffers extends StatefulWidget {
  final List<ProductData> productList;

  SpecialOffers({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.productList.length,
        itemBuilder: (_, i) => ProductCard(item: widget.productList[i]),
        separatorBuilder: (_, __) => SizedBox(width: 10),
      ),
    );
  }
}
