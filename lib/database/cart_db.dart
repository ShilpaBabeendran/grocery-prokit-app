import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDB {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await openDatabase(
      join(await getDatabasesPath(), "cart.db"),
      onCreate: (db, v) => db.execute(
          "CREATE TABLE cart(id TEXT PRIMARY KEY, name TEXT, price REAL, qty INTEGER)"),
      version: 1,
    );
    return _db!;
  }

  static Future<void> add(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert("cart", item,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await database;
    return db.query("cart");
  }

  static Future<void> clear() async {
    final db = await database;
    await db.delete("cart");
  }

  static Future<void> delete(String id) async {
  final db = await database;
  await db.delete("cart", where: "id = ?", whereArgs: [id]);
}
}
