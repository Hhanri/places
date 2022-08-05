import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as db;

class DBHelper {

  static Future<db.Database> database() async {
    final dbPath = await db.getDatabasesPath();
    return db.openDatabase(
      join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)");
      },
      version: 1
    );
  }

  static Future<void> insert({required String table, required Map<String,dynamic> data}) async {
    final sqlDb = await database();
    sqlDb.insert(
      table,
      data,
      conflictAlgorithm: db.ConflictAlgorithm.replace
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await database();
    return sqlDb.query(table);
  }
}
