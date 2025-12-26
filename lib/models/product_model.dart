class ProductModel {
  final String id;
  final String name;
  final int price;
  final String qty;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.image,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      price: data['price'] ?? 0,
      qty: data['qty'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': product.id,
      'name': product.name,
      'image': product.image,
      'price': product.price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: ProductModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        image: map['image'] ?? '',
        price: map['price'] ?? 0,
        qty: '',
      ),
      quantity: map['quantity'] ?? 1,
    );
  }
}
