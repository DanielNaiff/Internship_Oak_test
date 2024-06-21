class Product {
  String name;
  String description;
  double price;
  bool availableForSale;
  String? imagePath;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.availableForSale,
    this.imagePath,
  });
}
