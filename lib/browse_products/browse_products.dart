import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/banner.dart';
class BrowseProducts extends StatefulWidget {
  const BrowseProducts({Key? key}) : super(key: key);

  @override
  _BrowseProductsState createState() => _BrowseProductsState();
}

class _BrowseProductsState extends State<BrowseProducts> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Container(
        color: themeData.backgroundColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            children: [
              SizedBox(
                child: SvgPicture.asset('assets/images/carrot.svg'),
                height: 40.0, width: 40.0,
              
              ),
             SizedBox(height: 5.0),
              Text('flightclub'.toUpperCase(), style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
            //   SearchField(),
              SizedBox(height: 10),
              Banners(),
            //   SizedBox(height: 10),
            //   _buildSectiontitle('Exclusive Offers', () {}),
            //   ExclusiveOffers(),
            //   SizedBox(height: 10),
            //   _buildSectiontitle('Best Sellings', () {}),
            //   BestSellings(),
            //   SizedBox(height: 10),
            //   _buildSectiontitle('Groceries', () {}),
            //   Groceries(),
            //   SizedBox(height: 10),
            //   _buildSectiontitle('Meats', () {}),
            //   Meats(),
            ],
          ),
        ),
      ),
    );
  }
//   Widget _buildSectiontitle(String title, [Function onTap]) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: kTitleStyle.copyWith(fontSize: 18),
//           ),
//           InkWell(
//             onTap: onTap ?? () {},
//             child: Text(
//               'See all',
//               style: TextStyle(color: kPrimaryColor),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
