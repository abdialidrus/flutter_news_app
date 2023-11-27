import 'package:flutter_news_app/src/news/data/data_sources/local/article_database.dart';
import 'package:flutter_news_app/src/news/data/data_sources/local/news_local_data_source.dart';
import 'package:flutter_news_app/src/news/data/models/article_model.dart';

class NewsLocalDataSourceImpl implements NewsLocalDataSource {

  final ArticleDatabase db;

  NewsLocalDataSourceImpl(this.db);

  @override
  Future<bool> checkIsArticleSaved({required ArticleModel articleModel}) async {
    final savedArticle = await db.fetchArticle(articleModel.url);
    return savedArticle != null;
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return await db.fetchAllArticles();
  }

  @override
  Future<void> saveArticle({required ArticleModel articleModel}) async {
    await db.insertArticle(articleModel);
  }

  @override
  Future<void> removeArticle({required ArticleModel articleModel}) async {
    await db.deleteArticle(articleModel.url);
  }

}
