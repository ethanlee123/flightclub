
import 'package:flutter/material.dart';

import 'product_card.dart';
import '../../blocs/product_bloc.dart';
import '../../models/product_data.dart';

class AllProducts extends StatefulWidget {
  final ProductBloc productBloc;
  AllProducts({Key? key, required this.productBloc}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    final List<ProductData> _items = widget.productBloc.productData;

    int productDataLength = _items.length;
    
   
    if (productDataLength == 0) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(height: 25, width: 25, child: CircularProgressIndicator(),),
          ],
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                height: MediaQuery.of(context).size.height * 0.28,
                child: ProductCard(item: _items[index]));
          },
          childCount: _items.length,
        ),
      );
    }
  }
}
