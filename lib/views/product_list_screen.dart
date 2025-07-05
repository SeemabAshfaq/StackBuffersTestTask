import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Text(
          'Home Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
