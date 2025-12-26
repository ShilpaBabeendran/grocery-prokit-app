import 'package:flutter/material.dart';
import '../models/product_model.dart';

class WishlistProvider extends ChangeNotifier {
  final List<ProductModel> _wishlist = [];

  List<ProductModel> get items => _wishlist;

  bool isWishlisted(String id) {
    return _wishlist.any((item) => item.id == id);
  }

  void toggleWishlist(ProductModel product) {
    final index = _wishlist.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      _wishlist.removeAt(index);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
  }

  void remove(ProductModel product) {
    _wishlist.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }
}