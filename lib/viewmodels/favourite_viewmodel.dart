import 'package:flutter/material.dart';
import 'package:stack_buffer_test_task/models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<ProductModel> _favoriteProducts = [];
  String _searchQuery = '';

  List<ProductModel> get favoriteProducts => _favoriteProducts;

  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  bool isFavorite(ProductModel product) =>
      _favoriteProducts.any((p) => p.id == product.id);

  void toggleFavorite(ProductModel product) {
    if (isFavorite(product)) {
      _favoriteProducts.removeWhere((p) => p.id == product.id);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }

  List<ProductModel> get filteredList => _favoriteProducts
      .where((p) =>
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();
}
