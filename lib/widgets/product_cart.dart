import 'package:flutter/material.dart';
import 'package:grocery_app/services/cart_provider.dart';
import 'package:grocery_app/provider/whishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel p;

  const ProductCard({super.key, required this.p});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final cart = Provider.of<CartProvider>(context);

    return Container(
      // width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: SingleChildScrollView(
        child: Card(
          // elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TOP ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(p.qty, style: const TextStyle(fontSize: 12)),
                    ),
                    SizedBox(width: 50),
                    GestureDetector(
                      onTap: () {
                        wishlist.toggleWishlist(p);
                      },
                      child: Icon(
                        wishlist.isWishlisted(p.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: wishlist.isWishlisted(p.id)
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// IMAGE
                Center(
                  child: Image.network(
                    p.image,
                    height: 80,
                    // fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 8),

                /// NAME & PRICE
                Text(
                  p.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "₹${p.price}",
                  style: TextStyle(color: Colors.grey.shade700),
                ),

                TextButton(
                  onPressed: () {
                    cart.addToCart(p);
                  },
                  child: Text(' Add To Cart'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
