import 'package:flutter_news_app/src/news/data/data_sources/local/article_database.dart';
import 'package:flutter_news_app/src/news/data/data_sources/local/news_local_data_source.dart';
import 'package:flutter_news_app/src/news/data/models/article_entity.dart';

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final ArticleDatabase db;

  NewsLocalDataSourceImpl(this.db);

  @override
  Future<bool> checkIsArticleSaved(
      {required ArticleEntity articleEntity}) async {
    final savedArticle = await db.fetchArticle(articleEntity.url);
    return savedArticle != null;
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    return await db.fetchAllArticles();
  }

  @override
  Future<void> saveArticle({required ArticleEntity articleEntity}) async {
    await db.insertArticle(articleEntity);
  }

  @override
  Future<void> removeArticle({required ArticleEntity articleEntity}) async {
    await db.deleteArticle(articleEntity.url);
  }
}
