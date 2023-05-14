import 'package:letsgo_food/data/model/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableFavorite = "favorite";

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var database = openDatabase(
      "$path/letsgofood.db",
      onCreate: (db, version) async {
        await db.execute(
          """
          CREATE TABLE $_tableFavorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            city TEXT,
            pictureId TEXT,
            rating REAL
          )
          """
        );
      },
      version: 1
    );
    return database;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tableFavorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getAllFavorites() async {
    final db = await database;
    var result = await db!.query(_tableFavorite);

    return result.map((json) => Restaurant.fromJson(json)).toList();
  }

  Future<Restaurant?> getFavoriteById(String id) async {
    final db = await database;

    var result = await db!.query(
      _tableFavorite,
      where: "id = ?",
      whereArgs: [id]
    );

    if (result.isNotEmpty) {
      return Restaurant.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tableFavorite,
      where: "id = ?",
      whereArgs: [id]
    );
  }
}
