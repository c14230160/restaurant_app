import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initializeDb();
    return _database!;
  }

  Future<Database> _initializeDb() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, 'restaurant.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE favorites(
          id TEXT PRIMARY KEY,
          name TEXT,
          city TEXT,
          pictureId TEXT,
          rating REAL
        )
        ''');
      },
    );
  }

  Future<void> insertFavorite(Map<String, dynamic> restaurant) async {
    final db = await database;

    await db.insert('favorites', {
      'id': restaurant['id'],
      'name': restaurant['name'],
      'city': restaurant['city'],
      'pictureId': restaurant['pictureId'],
      'rating': restaurant['rating'],
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;

    return db.query('favorites');
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;

    final result = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty;
  }
}
