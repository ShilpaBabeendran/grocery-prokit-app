import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/order_model.dart';
import 'package:grocery_app/pages/home_screen.dart';
import 'package:grocery_app/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScaffoldMessengerState _messenger;

  static const months = [
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _messenger = ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getMonth(int m) => months[m];

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xffffffff),),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        ),
        backgroundColor: const Color(0xFF00C853),
        title: const Text(
          "Order History",
          style: TextStyle(color: Colors.white),
        ),
        // iconTheme: const IconThemeData(color: Colors.white),
      
        bottom: TabBar(
          controller: _tabController,
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
          /// COMPLETED TAB
          StreamBuilder<List<OrderModel>>(
            stream: orderProvider.fetchCompletedOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No completed orders"));
              }

              final orders = snapshot.data!;

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final d = order.date.toDate();
                  final date = "${d.day} ${_getMonth(d.month)} ${d.year}";

                  return Card(
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0xFF00C853),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ),

                              Column(
                                children: [
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Subtotal ₹${order.totalAmount.toStringAsFixed(2)}",
                                  ),
                                  Text(
                                    "Items: ${order.items.length}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),

                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () async {
                                  // Call your delete function here
                                  await orderProvider.deleteOrder(order.id);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),

                          const Divider(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                onPressed: order.status == 'canceled'
                                    ? null
                                    : () async {
                                        try {
                                          await orderProvider.cancelOrder(
                                            order.id,
                                          );
                                          if (!mounted) return;
                                          _messenger.showSnackBar(
                                            const SnackBar(
                                              content: Text("Order canceled"),
                                            ),
                                          );
                                        } catch (e) {
                                          _messenger.showSnackBar(
                                            SnackBar(
                                              content: Text("Error: $e"),
                                            ),
                                          );
                                        }
                                      },
                                child: Text(
                                  order.status == 'canceled'
                                      ? "CANCELED"
                                      : "ORDER CANCEL",
                                  style: TextStyle(
                                    color: order.status == 'canceled'
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                ),
                              ),

                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/cart");
                                },
                                child: Text('VIEW CART'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          //UPCOMING
          const _EmptyTab("No upcoming orders"),

          //canceled order
          StreamBuilder<List<OrderModel>>(
            stream: orderProvider.fetchOrdersByStatus("canceled"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No canceled orders"));
              }

              final orders = snapshot.data!;

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (_, index) {
                  final order = orders[index];
                  final dateTime = order.date.toDate();
                  final date =
                      "${dateTime.day}/${dateTime.month}/${dateTime.year}";

                  return Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Canceled on $date",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(Icons.cancel, color: Colors.red),
                          ],
                        ),
                        const Divider(),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: order.items.length,
                          itemBuilder: (_, i) {
                            final item = order.items[i];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Image.network(
                                item.product.image,
                                width: 40,
                                height: 40,
                              ),
                              title: Text(item.product.name),
                              subtitle: Text(
                                "₹${item.product.price} × ${item.quantity}",
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Total ₹${order.totalAmount}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EmptyTab extends StatelessWidget {
  final String text;
  const _EmptyTab(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
