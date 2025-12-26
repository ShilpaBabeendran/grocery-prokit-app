import 'package:flutter/material.dart';
import 'package:grocery_app/provider/order_provider.dart';
import 'package:grocery_app/utils/flutter_toast.dart';
import 'package:provider/provider.dart';
import '../services/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF00C853),
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (_, index) {
                      final cartItem = cart.items[index];

                      return ListTile(
                        leading: Image.network(
                          cartItem.product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(cartItem.product.name),
                        subtitle: Text(
                          "₹${cartItem.product.price} × ${cartItem.quantity}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  cart.decrementQty(cartItem),
                            ),
                            Text(cartItem.quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  cart.incrementQty(cartItem),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => cart.remove(cartItem),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// BUY NOW SECTION
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Total: ₹${cart.totalPrice}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00C853),
                          ),
                          onPressed: () async {
                            final cartProvider =
                                context.read<CartProvider>();
                            final orderProvider =
                                context.read<OrderProvider>();

                            await orderProvider.placeOrder(
                              items: cartProvider.items,
                              total: cartProvider.totalPrice,
                            );

                            cartProvider.clearCart();

                            await Message.show(
                              message: "Order placed successfully",
                            );

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
