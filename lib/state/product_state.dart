import 'package:flutter/material.dart';
import 'package:product_inventory_internship_oak_tecnologia/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products =>
      _products..sort((a, b) => a.price.compareTo(b.price));

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(int index, Product product) {
    _products[index] = product;
    notifyListeners();
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }
}
