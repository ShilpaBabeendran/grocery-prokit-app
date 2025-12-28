import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/product_model.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final Timestamp date;
  final String status;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((e) => e.toMap()).toList(),
      'totalAmount': totalAmount,
      'date': date,
      'status': status,
    };
  }

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      id: doc.id,
      items: (data['items'] as List)
          .map((e) => CartItem.fromMap(e))
          .toList(),
      totalAmount: (data['totalAmount'] as num).toDouble(),
      date: data['date'],
      status: data['status'],
    );
  }

  
}
