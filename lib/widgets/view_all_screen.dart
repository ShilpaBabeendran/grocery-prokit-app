import 'package:flutter/material.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/widgets/product_cart.dart';
import 'package:provider/provider.dart';
// import '../provider/product_provider.dart';
// import '../widgets/product_card.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (_, i) => ProductCard(p: products[i]),
      ),
    );
  }
}
