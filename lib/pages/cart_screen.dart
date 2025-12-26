import 'package:flutter/material.dart';
import 'package:grocery_app/provider/order_provider.dart';
import 'package:grocery_app/utils/flutter_toast.dart';
import 'package:provider/provider.dart';
import '../services/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart", style: TextStyle(color: Color(0xffffffff))),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xffffffff)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                              onPressed: () => cart.decrementQty(cartItem),
                            ),
                            Text(cartItem.quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => cart.incrementQty(cartItem),
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
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final cartProvider = context.read<CartProvider>();
                            final orderProvider = context.read<OrderProvider>();

                            await orderProvider.placeOrder(
                              items: cartProvider.items,
                              total: cartProvider.totalPrice,
                            );

                            cartProvider.clearCart();

                            await Message.show(
                              message: "Order placed successfully",
                            );

                            if (context.mounted) {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            }
                          },

                          child: const Text("Buy Now"),
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
