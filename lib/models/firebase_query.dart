import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_pagination'

class FirebaseQuery {
  static final productCollection =
      FirebaseFirestore.instance.collection('products');

  static Future<QuerySnapshot> getProducts(int limit,
      {DocumentSnapshot? startAfter}) async {
    final productLimit = productCollection.limit(limit);
    if (startAfter == null) {
      return productLimit.get();
    }

    return productLimit.startAfterDocument(startAfter).get();
  }

  static Future<QuerySnapshot> getSpecialProducts(
      int limit, String special) async {
    final productFiltered;

    switch (special) {
      case 'featured':
        {
          productFiltered =
              productCollection.where('featured', isEqualTo: true);
        }
        break;
      case 'exclusive':
        {
          productFiltered =
              productCollection.where('exclusive', isEqualTo: true);
        }
        break;
      default:
        {
          productFiltered = productCollection;
        }
        break;
    }
    final productLimited = productFiltered.limit(limit);

    return productLimited.get();
  }

  static Future<void> massWriteProducts() async {
    List<Map<String, dynamic>> prods = [
      {
        'category': 'food',
        'description': '1kg pineapple',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/fruit.png',
        'name': 'mango',
        'price': 5.99,
        'sku': 'f-1-fc'
      },
      {
        'category': 'food',
        'description': '1kg mango',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/fruit.png',
        'name': 'mango',
        'price': 5.99,
        'sku': 'f-2-fc'
      },
      {
        'category': 'food',
        'description': '1kg mango',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/fruit.png',
        'name': 'mango',
        'price': 5.99,
        'sku': 'f-3-fc'
      },
      {
        'category': 'food',
        'description': '1kg guava',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/fruit.png',
        'name': 'guava',
        'price': 5.99,
        'sku': 'f-4-fc'
      },
      {
        'category': 'food',
        'description': '1kg jackfruit',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/fruit.png',
        'name': 'jackfruit',
        'price': 5.99,
        'sku': 'f-5-fc'
      },
      {
        'category': 'food',
        'description': '1kg strawberry',
        'exclusive': true,
        'featured': false,
        'image': 'assets/images/fruit.png',
        'name': 'strawberry',
        'price': 5.99,
        'sku': 'f-6-fc'
      },
      {
        'category': 'home',
        'description': 'mac inspired candle by twelve south',
        'exclusive': false,
        'featured': true,
        'image': 'assets/images/home.png',
        'name': 'mac inspired candle',
        'price': 29.99,
        'sku': 'h-1-fc'
      },
      {
        'category': 'accessories',
        'description': 'cup holder that attaches to poles on the subway',
        'exclusive': true,
        'featured': true,
        'image': 'assets/images/home.png',
        'name': 'Comfycup Public Cup Holder',
        'price': 5.99,
        'sku': 'h-2-fc'
      },
      {
        'category': 'food',
        'description': 'Add a twinkling touch to your desserts',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/home.png',
        'name': 'wilton edible glitter',
        'price': 7.23,
        'sku': 'f-7-fc'
      },
      {
        'category': 'home',
        'description': 'avocado-shaped guac bowl',
        'exclusive': false,
        'featured': true,
        'image': 'assets/images/home.png',
        'name': 'Guacamole Bowl',
        'price': 23.27,
        'sku': 'h-3-fc'
      },
      {
        'category': 'home',
        'description': 'For the Gremlin fans!',
        'exclusive': true,
        'featured': true,
        'image': 'assets/images/home.png',
        'name': 'Chia Pet Gremlim',
        'price': 29.99,
        'sku': 'h-4-fc'
      },
      {
        'category': 'home',
        'description': '188-inch inflatable elephant',
        'exclusive': false,
        'featured': true,
        'image': 'assets/images/home.png',
        'name': 'Likelike inflatable elephant',
        'price': 50.99,
        'sku': 'h-5-fc'
      },
      {
        'category': 'tech',
        'description':
            'Phone-addicts beware: you need a key to open up the lock on this cell',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/computer.png',
        'name': 'Mobile Phone Jail Cell',
        'price': 15.99,
        'sku': 't-1-fc'
      },
      {
        'category': 'tech',
        'description':
            'This microphone connects back to your own earbud, in case you can\'t get enough of your own voice',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/computer.png',
        'name': 'Karaoke Earphone',
        'price': 5.99,
        'sku': 't-2-fc'
      },
      {
        'category': 'tech',
        'description': 'tiny video camera on a 3 axis gimbal',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/computer.png',
        'name': 'DJI osmo pocket',
        'price': 450.00,
        'sku': 't-3-fc'
      },
      {
        'category': 'tech',
        'description': 'digital paper notebook with a pen to go with it',
        'exclusive': true,
        'featured': false,
        'image': 'assets/images/computer.png',
        'name': 'Moleskine pen + smart writing set',
        'price': 308.99,
        'sku': 't-4-fc'
      },
      {
        'category': 'tech',
        'description': 'an electric muscle stimulator',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/computer.png',
        'name': 'power dot 2.0',
        'price': 95.99,
        'sku': 't-5-fc'
      },
      {
        'category': 'miscellaneous',
        'description': 'Pack of 3 potato chip grabber, finger covers',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/miscellaneous.png',
        'name': 'Finger Covers for Cheesy Food',
        'price': 17.00,
        'sku': 'm-1-fc'
      },
      {
        'category': 'miscellaneous',
        'description': 'This tray slides right into your cup holder',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/miscellaneous.png',
        'name': 'Car french fry holder',
        'price': 8.00,
        'sku': 'm-2-fc'
      },
      {
        'category': 'miscellaneous',
        'description': 'by THENICE',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/miscellaneous.png',
        'name': 'Anatomy bathing suit',
        'price': 16.99,
        'sku': 'm-3-fc'
      },
      {
        'category': 'miscellaneous',
        'description': 'Garden gnome statues',
        'exclusive': true,
        'featured': false,
        'image': 'assets/images/miscellaneous.png',
        'name': 'Selfie sisters garden gnome',
        'price': 18.99,
        'sku': 'm-4-fc'
      },
      {
        'category': 'miscellaneous',
        'description': 'Literally a hand bag that looks like a hen',
        'exclusive': false,
        'featured': true,
        'image': 'assets/images/miscellaneous.png',
        'name': 'The Hen Bag Handbag',
        'price': 28.99,
        'sku': 'm-5-fc'
      },
      {
        'category': 'miscellaneous',
        'description': '25 bacon themed bandages, nuff said',
        'exclusive': false,
        'featured': false,
        'image': 'assets/images/miscellaneous.png',
        'name': 'Bacon strip bandages',
        'price': 18.99,
        'sku': 'm-5-fc'
      },
      {
        'category': 'miscellaneous',
        'description': 'tiny hands that go on your finger tips',
        'exclusive': true,
        'featured': true,
        'image': 'assets/images/miscellaneous.png',
        'name': 'Finger Hands Finger Puppets',
        'price': 6.89,
        'sku': 'm-6-fc'
      },
      {
        'category': 'miscellaneous',
        'description':
            'Use it for power naps at your desk or to lounge at home',
        'exclusive': true,
        'featured': true,
        'image': 'assets/images/miscellaneous.png',
        'name': 'Original ostrich pillow',
        'price': 96.27,
        'sku': 'm-7-fc'
      },
    ];
    prods.forEach((element) {
      productCollection
          .add(element)
          .then((value) => print('successfully written to products'))
          .catchError((error) => print('failed to add: $error'));
    });
  }
}
