import 'package:flightclub/blocs/cart_bloc.dart';
import 'package:flightclub/blocs/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'components/all_products.dart';
import 'components/banner.dart';
import 'components/special_offers.dart';
import '../../blocs/product_bloc.dart';

class BrowseProducts extends StatefulWidget {
  const BrowseProducts({Key? key}) : super(key: key);

  @override
  _BrowseProductsState createState() => _BrowseProductsState();
}

class _BrowseProductsState extends State<BrowseProducts> {
  late ProductBloc productBloc;
  late ScrollController scrollController = ScrollController();

  @override
  void initState() {
    productBloc = Provider.of<ProductBloc>(context, listen: false);

    productBloc.fetchSpecialProducts('exclusive');
    productBloc.fetchSpecialProducts('featured');
    productBloc.fetchNextProducts();

    scrollController.addListener(scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    productBloc.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (productBloc.hasNext) {
        productBloc.fetchNextProducts();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productBloc = Provider.of<ProductBloc>(context);

    ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          color: themeData.backgroundColor,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      child: SvgPicture.asset('assets/images/carrot.svg'),
                      height: 30.0,
                      width: 30.0,
                    ),
                    Text('flightclub'.toUpperCase(),
                        style: themeData.accentTextTheme.headline5,
                        textAlign: TextAlign.center),
                    _shopMenu(context),
                    Banners(),
                    SizedBox(height: 10),
                    _buildSectiontitle('Exclusive Offers', context),
                    SpecialOffers(
                        productList: productBloc.exclusiveProductData),
                    _buildSectiontitle('Featured', context),
                    SpecialOffers(productList: productBloc.featuredProductData),
                    _buildSectiontitle('All', context),
                  ],
                ),
              ),
              AllProducts(),
              if (productBloc.hasNext)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Center(
                        child: GestureDetector(
                          onTap: productBloc.fetchNextProducts,
                          child: Container(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectiontitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).accentTextTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  Widget _shopMenu(BuildContext context) {
    final mapBloc = Provider.of<MapBloc>(context);
    final cart = Provider.of<CartBloc>(context);

    String _dropoffLocation =
        mapBloc.placeDetails?.formattedAddress ?? 'Choose Location';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(Icons.location_on_rounded),
            label: Text('$_dropoffLocation'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Stack(
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.pushNamed(context, '/checkout');
                        },
                      ),
                      Positioned(
                          top: 3.0,
                          right: 4.0,
                          child: Center(child: Text('${cart.quantity}')))
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
