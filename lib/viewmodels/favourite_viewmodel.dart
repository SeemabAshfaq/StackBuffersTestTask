import 'package:flutter/material.dart';
import 'package:stack_buffer_test_task/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavouriteViewmodel extends ChangeNotifier {
  final List<ProductModel> _favoriteProducts = [];
  String _searchQuery = '';

  FavouriteViewmodel() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favourites') ?? [];
    _favoriteProducts.clear();
    _favoriteProducts.addAll(
      favs.map((e) => ProductModel.fromJson(json.decode(e))),
    );
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = _favoriteProducts.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('favourites', favs);
  }

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
    _saveFavorites();
    notifyListeners();
  }

  List<ProductModel> get filteredList => _favoriteProducts
      .where((p) => p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();
}
