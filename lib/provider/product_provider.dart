import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();

    products = snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.data(), doc.id))
        .toList();

    notifyListeners();
  }
}

