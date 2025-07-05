import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stack_buffer_test_task/core/snackbar_service.dart';
import 'package:stack_buffer_test_task/models/product_model.dart';
import 'package:stack_buffer_test_task/views/product_details_screen.dart';

class ProductViewModel extends ChangeNotifier {
  List<ProductModel> _productList = [];
  String _searchQuery = '';
  bool _isLoading = false;
  ProductModel? _product;

  List<ProductModel> get productList => _productList;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  ProductModel? get product => _product;

  List<ProductModel> get filteredList {
    if (_searchQuery.isEmpty) return _productList;
    return _productList
        .where((p) => p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  ProductViewModel() {
    loadProducts();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }



  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _productList = (data as List).map((e) => ProductModel.fromJson(e)).toList();
      }
    } catch (e) {
    SnackbarService.showSnackbar(message: e.toString(),title: "Error", icon: Icons.error_outline);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductDetails(BuildContext context, int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _product = ProductModel.fromJson(jsonData);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: _product!),
          ),
        );
      }
    } catch (e) {
      // Handle error
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
