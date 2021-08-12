class ProductData {
  late final String category;
  late final String description;
  late final bool exclusive;
  late final bool featured;
  late final String image;
  late final String name;
  late final double price;
  late final String sku;

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
  
  // Override == operator to compare sku (should always be unique) and name
  @override
  bool operator ==(covariant ProductData other) =>
      (this.sku == other.sku && this.name == other.name);

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + sku.hashCode;
    result = 37 * result + name.hashCode;
    return result;
  }
}
