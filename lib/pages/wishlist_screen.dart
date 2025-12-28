import 'package:flutter/material.dart';
import 'package:grocery_app/provider/whishlist_provider.dart';
import 'package:grocery_app/services/cart_provider.dart';
import 'package:provider/provider.dart';


class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context);
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00C569),
        title: const Text("Wishlist", style: TextStyle(color: Color(0xffffffff)),),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xffffffff),),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: wishlist.items.isEmpty
          ? const Center(child: Text("No items in wishlist"))
          : ListView.builder(
              itemCount: wishlist.items.length,
              itemBuilder: (_, index) {
                final item = wishlist.items[index];

                return ListTile(
                  leading: Image.network(item.image, width: 50),
                  title: Text(item.name),
                  subtitle: Text("₹${item.price}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          cart.addToCart(item);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          wishlist.remove(item);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
