class Product {
  final String name;
  final String price;
  final String imageUrl;
  final String description;
  final String uniqueID;
  final String isAvaliable;

  Product({
    required this.isAvaliable,
    required this.uniqueID,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  String toString() {
    return 'Product{name: $name, price: $price, imageUrl: $imageUrl, description: $description, uniqueID: $uniqueID, isAvaliable: $isAvaliable}';
  }
}
