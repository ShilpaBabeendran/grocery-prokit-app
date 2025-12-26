import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/order_model.dart';
import 'package:grocery_app/models/product_model.dart';

class OrderProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// PLACE ORDER (BUY NOW)
  Future<void> placeOrder({
    required List<CartItem> items,
    required int total,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .add({
      'items': items.map((e) => e.toMap()).toList(),
      'totalAmount': total,                 
      'date': Timestamp.now(),              
      'status': 'completed',
    });
  }

  /// FETCH ORDERS -ORDERHSRY
  Stream<List<OrderModel>> fetchOrders() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .orderBy('date', descending: true)  
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OrderModel.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> deleteOrder(String orderId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('orders')
      .doc(orderId)
      .delete();
}

}
