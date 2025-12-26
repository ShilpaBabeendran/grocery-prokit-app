import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/product_model.dart';

class OrderModel {
  final String id;
  final Timestamp date;
  final int totalAmount;
  final List<CartItem> items;
  final String status;

  OrderModel({
    required this.id,
    required this.date,
    required this.totalAmount,
    required this.items,
    this.status = "completed",
  });

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((e) => e.toMap()).toList(),
      'totalAmount': totalAmount,
      'date': date,
      'status': status,
    };
  }

  factory OrderModel.fromFirestore(String id, Map<String, dynamic> data) {
    return OrderModel(
      id: id,
      date: data['date'],
      totalAmount: data['totalAmount'],
      status: data['status'],
      items: (data['items'] as List)
          .map((e) => CartItem.fromMap(e))
          .toList(),
    );
  }

  
}
