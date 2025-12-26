import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/order_model.dart';
import 'package:grocery_app/models/product_model.dart';


class OrderProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  /// placeorder
  Future<void> placeOrder({
    required List<CartItem> items,
    required int total,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .add({
      'items': items.map((e) => e.toMap()).toList(),
      'total': total,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  /// order fletch
  Stream<List<OrderModel>> fetchOrders() {
    final user = FirebaseAuth.instance.currentUser;

    return _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc.id, doc.data()))
          .toList();
    });
  }
}
