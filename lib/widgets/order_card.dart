import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String date;
  final int total;
  final int itemsCount;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const OrderCard({
    super.key,
    required this.date,
    required this.total,
    required this.itemsCount,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xff1abc9c),
                child: Icon(Icons.shopping_cart, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Subtotal Rs. $total.00",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "Total items: ${itemsCount.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.white54),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onView,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black,
              ),
              child: const Text("VIEW CART"),
            ),
          ),
        ],
      ),
    );
  }
}
