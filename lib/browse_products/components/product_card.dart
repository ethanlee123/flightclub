
import 'package:flightclub/models/product_data.dart';
import 'package:flutter/material.dart';
// import 'package:grocery_shop/models/models.dart';
// import 'package:grocery_shop/screens/details_screen/item_details_screen.dart';

// import '../../../constants.dart';
// import '../../../mq.dart';

class ProductCard extends StatelessWidget {
  final Product item;
  const ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  void onTap(BuildContext context) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (_) => ItemDetailsSreen(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
      
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
              color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: item.hashCode,
                  child: Image.asset(
                    item.url,
                    height: constraints.maxHeight * 0.4,
                  ),
                ),
                SizedBox(height: 10),
                Text(item.name,),
                Text(item.description,),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price}',
                    //   style: kTitleStyle.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Container(
                        
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        // color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 20,
                        // color: Colors.white,
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
}
