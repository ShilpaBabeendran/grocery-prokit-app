import 'package:flutter/material.dart';
import 'package:grocery_app/provider/order_provider.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
    
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C853),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Order History",
            style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          tabs: const [
            Tab(text: "COMPLETED"),
            Tab(text: "UPCOMING"),
            Tab(text: "CANCELED"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          /// COMPLETED ORDERS
          StreamBuilder(
            stream: orderProvider.fetchOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No completed orders",
                     ),
                );
              }

              final orders = snapshot.data!;

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (_, index) {
                  final order = orders[index];
                  final dateTime = order.date.toDate();

                  final date =
                      "${dateTime.day} ${_getMonth(dateTime.month)} ${dateTime.year}";

                  return Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(),
                      
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                        /// PRODUCT LIST
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: order.items.length,
                          itemBuilder: (_, i) {
                            final item = order.items[i];

                            return ListTile(
                              leading: Image.network(
                                item.product.image,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                item.product.name,
                                style: const TextStyle(
                                    ),
                              ),
                              subtitle: Text(
                                "₹${item.product.price} × ${item.quantity}",
                                style: const TextStyle(
                                    color: Colors.grey),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 5),

                        /// TOTAL + VIEW CART
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total ₹${order.totalAmount}",
                              style: const TextStyle(
                                  
                                  fontWeight: FontWeight.bold),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                _showCartDialog(context, order.items);
                              },
                              child: const Text("VIEW CART",
                                  style:
                                      TextStyle(color: Colors.green)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.grey),
                              onPressed: () async {
                                await orderProvider
                                    .deleteOrder(order.id);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          const _EmptyTab(message: "No upcoming orders"),
          const _EmptyTab(message: "No canceled orders"),
        ],
      ),
    );
  }

  void _showCartDialog(BuildContext context, List<CartItem> items) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Order Items"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];
              return ListTile(
                leading: Image.network(
                  item.product.image,
                  width: 40,
                  height: 40,
                ),
                title: Text(item.product.name),
                subtitle: Text(
                    "₹${item.product.price} × ${item.quantity}"),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  String _getMonth(int month) {
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month];
  }
}

class _EmptyTab extends StatelessWidget {
  final String message;
  const _EmptyTab({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message,
          style: const TextStyle(color: Colors.white54)),
    );
  }
}
