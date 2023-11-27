import 'package:flutter/foundation.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/data/models/article_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ArticleDatabase {
  static Database? _database;

  ArticleDatabase();

  Future<Database?> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await init();

    return _database;
  }

  Future<Database> init() async {
    String dbPath = join(await getDatabasesPath(), 'world_news_database.db');
    var database = openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
     CREATE TABLE articles(
        title TEXT,
        source TEXT,
        url TEXT PRIMARY KEY,
        url_to_image TEXT,
        description TEXT,
        published_at TEXT)
    ''');
    if (kDebugMode) {
      print('Database was created!');
    }
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> insertArticle(ArticleModel articleModel) async {
    var client = await db;
    return client!.insert(
      'articles',
      articleModel.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteArticle(String articleUrl) async {
    var client = await db;
    client!.delete(
      'articles',
      where: 'url = ?',
      whereArgs: [articleUrl],
    );
  }

  Future<ArticleModel?> fetchArticle(String articleUrl) async {
    var client = await db;
    final Future<List<DataMap>> futureMaps = client!.query(
      'articles',
      where: 'url = ?',
      whereArgs: [articleUrl],
    );
    var maps = await futureMaps;

    if (maps.isNotEmpty) {
      return ArticleModel.fromMapDb(maps.first);
    }

    return null;
  }

  Future<List<ArticleModel>> fetchAllArticles() async {
    var client = await db;
    var res = await client!.query('articles');

    if (res.isNotEmpty) {
      var articles =
          res.map((articleMap) => ArticleModel.fromMapDb(articleMap)).toList();
      return articles;
    }
    return [];
  }
}
