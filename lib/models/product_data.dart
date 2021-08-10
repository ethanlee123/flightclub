class ProductData {
  late String category;
  late String description;
  late bool exclusive;
  late bool featured;
  late String image;
  late String name;
  late double price;
  late String sku;

  ProductData(
      {required this.category,
      required this.description,
      required this.exclusive,
      required this.featured,
      required this.name,
      required this.price,
      required this.sku,
      String image = 'assets/image/drone_art.png'}) {
          this.image = image;
      }
}