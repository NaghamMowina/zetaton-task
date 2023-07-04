import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zetaton_task/features/favorites/model/favorites_model.dart';

class DB {
  static final DB instance = DB._init();

  static Database? _database;

  DB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pexel.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "create table favorites(favoriteId integer primary key autoincrement, smallImgUrl text, originalImgUrl text, photoId integer)");
  }

  Future<int> insertFavorite(FavoritePhotoModel favoritePhotoModel) async {
    final db = await instance.database;
    return db.insert("favorites", favoritePhotoModel.toMap());
  }

  Future<int> removeFavorite(int id) async {
    final db = await instance.database;
    return await db.delete('favorites', where: 'photoId = ?', whereArgs: [id]);
  }

  Future<bool> checkFavoriteExist(FavoritePhotoModel favoritePhotoModel) async {
    final db = await instance.database;
    final result = await db.query('favorites',
        where: 'photoId = ?', whereArgs: [favoritePhotoModel.photoId]);
    List<FavoritePhotoModel> results =
        result.map((json) => FavoritePhotoModel.fromMap(json)).toList();
    return results.isNotEmpty;
  }

  Future<List<FavoritePhotoModel>> getFavorites() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(
        maps.length, (index) => FavoritePhotoModel.fromMap(maps[index]));
  }
}
