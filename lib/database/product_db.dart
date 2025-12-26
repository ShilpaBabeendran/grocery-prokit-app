import 'package:grocery_app/database/app_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:grocery_app/models/product_model.dart';

class ProductDao {
  /// INSERT OR UPDATE PRODUCT
  static Future<void> insertProduct(ProductModel product) async {
    final db = await AppDatabase.database;

    await db.insert(
      'products',
      {
        'id': product.id,
        'qty': product.qty,
        'image': product.image,
        'name': product.name,
        'price': product.price,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// INSERT MULTIPLE PRODUCTS
  static Future<void> insertProducts(List<ProductModel> products) async {
    final db = await AppDatabase.database;
    final batch = db.batch();

    for (var product in products) {
      batch.insert(
        'products',
        {
          'id': product.id,
          'qty': product.qty,
          'image': product.image,
          'name': product.name,
          'price': product.price,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  /// GET ALL PRODUCTS
  static Future<List<ProductModel>> getProducts() async {
    final db = await AppDatabase.database;
    final result = await db.query('products');

    return result.map((e) => ProductModel(
      id: e['id'] as String,
      qty: e['qty'].toString(),
      image: e['image'] as String,
      name: e['name'] as String,
      price: (e['price'] as num).toInt(),
    )).toList();
  }

  /// GET PRODUCT BY ID
  static Future<ProductModel?> getProductById(String id) async {
    final db = await AppDatabase.database;
    final result =
        await db.query('products', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) return null;
    final e = result.first;
    return ProductModel(
      id: e['id'] as String,
      qty: e['qty'].toString(),
      image: e['image'] as String,
      name: e['name'] as String,
      price: (e['price'] as num).toInt(),
    );
  }

  /// CLEAR TABLE
  static Future<void> clearProducts() async {
    final db = await AppDatabase.database;
    await db.delete('products');
  }
}
