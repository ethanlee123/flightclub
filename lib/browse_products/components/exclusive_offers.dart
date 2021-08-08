import '../../models/product_data.dart';
import 'package:flutter/material.dart';


// import 'grocery_item.dart';ks
import 'product_card.dart';

class ExclusiveOffers extends StatelessWidget {
  ExclusiveOffers({
    Key? key,
  }) : super(key: key);

  final List<Product> _items = [
    Product(
      name: 'Organic Bananas',
      url: 'assets/images/drone_art.png',
      description: '7pcs',
      price: 4.99,
    ),
    Product(
      name: 'Red Apple',
      url: 'assets/images/drone_art.png',
      description: '1kg',
      price: 5.99,
    ),
    Product(
      name: 'Red Pepper',
      url: 'assets/images/drone_art.png',
      description: '1kg',
      price: 3.99,
    ),
    Product(
      name: 'Red Apple',
      url: 'assets/images/drone_art.png',
      description: '1kg',
      price: 5.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        itemBuilder: (_, i) => ProductCard(item: _items[i]),
        separatorBuilder: (_, __) => SizedBox(width: 10),
      ),
    );
  }
}