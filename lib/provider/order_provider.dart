import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/order_model.dart';
import 'package:grocery_app/models/product_model.dart';

class OrderProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ================= PLACE ORDER =================
  Future<String> placeOrder({
    required List<CartItem> items,
    required double total,
  }) async {
    final uid = _auth.currentUser!.uid;

    final docRef = await _firestore.collection('orders').add({
      "userId": uid,
      "items": items.map((e) => e.toMap()).toList(),
      "totalAmount": total,
      "status": "completed",
      "date": Timestamp.now(),
    });

    return docRef.id;
  }

  /// ================= COMPLETED ORDERS =================
  ///
  Stream<List<OrderModel>> fetchCompletedOrders() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('orders')
        .where("userId", isEqualTo: uid)
        .where("status", whereIn: ["completed", "canceled"])
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => OrderModel.fromFirestore(doc))
              .toList();
        });
  }

  // CANCELED ORDERS
  Stream<List<OrderModel>> fetchCanceledOrders() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .where('status', isEqualTo: 'canceled')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromFirestore(doc))
              .toList(),
        );
  }

  //FETCH ORDERS
  Stream<List<OrderModel>> fetchOrdersByStatus(String status) {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .where('status', isEqualTo: status)
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromFirestore(doc))
              .toList(),
        );
  }

  //  CANCEL ORDER
  Future<void> cancelOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'canceled',
      'canceledAt': Timestamp.now(),
    });
  }

  // DELETE ORDER
  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).delete();
  }
}
