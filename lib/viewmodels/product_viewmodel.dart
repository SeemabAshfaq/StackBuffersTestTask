import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stack_buffer_test_task/core/snackbar_service.dart';
import 'package:stack_buffer_test_task/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductViewModel extends ChangeNotifier {
  List<ProductModel> _productList = [];
  String _searchQuery = '';
  bool _isLoading = false;
  ProductModel? _product;
  int _visibleCount = 20;

  List<ProductModel> get productList => _productList;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  ProductModel? get product => _product;
  int get visibleCount => _visibleCount;

  List<ProductModel> get filteredList {
    if (_searchQuery.isEmpty) return _productList;
    return _productList
        .where(
          (p) => p.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  List<ProductModel> get visibleProducts {
    final list = filteredList;
    return list.take(_visibleCount).toList();
  }

  ProductViewModel() {
    loadProducts();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    resetVisibleCount();
    notifyListeners();
  }

  void increaseVisibleCount([int increment = 20]) {
    if (_visibleCount < filteredList.length) {
      _visibleCount = (_visibleCount + increment).clamp(0, filteredList.length);
      notifyListeners();
    }
  }

  void resetVisibleCount() {
    _visibleCount = 20;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _productList = (data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        resetVisibleCount();
      }
    } catch (e) {
      SnackbarService.showSnackbar(message: e.toString(), title: "Error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductDetails(BuildContext context, int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/$id'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _product = ProductModel.fromJson(data);

        //  Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (_) => ProductDetailScreen(product: _product!),
        //     ),
        //   );
        Navigator.pushNamed(context, '/productDetails', arguments: _product);
      }
    } catch (e) {
      SnackbarService.showSnackbar(message: e.toString(), title: "Error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _searchQuery = '';
    notifyListeners();
  }
}
