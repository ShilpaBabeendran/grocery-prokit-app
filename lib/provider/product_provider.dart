import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();

      _products = snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
