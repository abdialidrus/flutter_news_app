import 'package:flutter_news_app/src/news/data/models/article_model.dart';

abstract class NewsLocalDataSource {

  Future<List<ArticleModel>> getSavedArticles();

  Future<void> saveArticle({required ArticleModel articleModel});

  Future<void> removeArticle({required ArticleModel articleModel});

  Future<bool> checkIsArticleSaved({required ArticleModel articleModel});
}