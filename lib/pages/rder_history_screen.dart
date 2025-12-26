// import 'package:flutter/material.dart';
// import 'package:grocery_app/provider/order_provider.dart';
// import 'package:provider/provider.dart';
// // import 'package:intl/intl.dart';

// class OrderHistoryScreen extends StatefulWidget {
//   const OrderHistoryScreen({super.key});

//   @override
//   State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
// }

// class _OrderHistoryScreenState extends State<OrderHistoryScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderProvider = context.read<OrderProvider>();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: const Color(0xff1abc9c),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text("Order History"),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 12),
//             child: Icon(Icons.search),
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           tabs: const [
//             Tab(text: "COMPLETED"),
//             Tab(text: "UP COMMING"),
//             Tab(text: "CANCELED"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           ///  COMPLETED ORDERS
//           StreamBuilder(
//             stream: orderProvider.fetchOrders(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               final orders = snapshot.data!;

//               if (orders.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     "No completed orders",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 );
//               }

//               return ListView.builder(
//                 itemCount: orders.length,
//                 itemBuilder: (_, index) {
//                   final order = orders[index];
//                   final date =
//                       "${order.date.toDate().day} ${_getMonth(order.date.toDate().month)} ${order.date.toDate().year}";

//                   return Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[900],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             const CircleAvatar(
//                               backgroundColor: Color(0xff1abc9c),
//                               child: Icon(
//                                 Icons.shopping_cart,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Text(
//                               date,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const Spacer(),
//                             IconButton(
//                               icon: const Icon(
//                                 Icons.delete,
//                                 color: Colors.grey,
//                               ),
//                               onPressed: () {},
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           "Subtotal Rs. ${order.totalAmount}.00",
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                           ),
//                         ),
//                         Text(
//                           "Total items: ${order.items.length}",
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 13,
//                           ),
//                         ),
//                         const Divider(color: Colors.grey),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.grey.shade400,
//                             ),
//                             onPressed: () {},
//                             child: const Text(
//                               "VIEW CART",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           ),

//           ///  UP COMMING
//           const _EmptyTab(message: "No upcoming orders"),

//           /// CANCELED
//           const _EmptyTab(message: "No canceled orders"),
//         ],
//       ),
//     );
//   }

//   String _getMonth(int month) {
//     const months = [
//       "",
//       "January",
//       "February",
//       "March",
//       "April",
//       "May",
//       "June",
//       "July",
//       "August",
//       "September",
//       "October",
//       "November",
//       "December",
//     ];
//     return months[month];
//   }
// }

// class _EmptyTab extends StatelessWidget {
//   final String message;

//   const _EmptyTab({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         message,
//         style: const TextStyle(color: Colors.white54, fontSize: 16),
//       ),
//     );
//   }
// }
