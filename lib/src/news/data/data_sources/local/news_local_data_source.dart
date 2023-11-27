import 'package:flutter_news_app/src/news/data/models/article_entity.dart';

abstract class NewsLocalDataSource {

  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> saveArticle({required ArticleEntity articleEntity});

  Future<void> removeArticle({required ArticleEntity articleEntity});

  Future<bool> checkIsArticleSaved({required ArticleEntity articleEntity});
}