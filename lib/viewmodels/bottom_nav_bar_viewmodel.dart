import 'package:flutter/material.dart';
import 'package:stack_buffer_test_task/viewmodels/product_provider.dart';
import 'package:stack_buffer_test_task/viewmodels/product_viewmodel.dart';

class BottomNavProvider extends ChangeNotifier {
  final ProductViewModel productProvider;

  BottomNavProvider({
    required this.productProvider,
  });

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();

    if (index == 0) {
      productProvider.setSearchQuery('');
      productProvider.loadProducts();
    } 
  }
}
