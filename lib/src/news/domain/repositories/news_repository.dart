import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';

abstract class NewsRepository {
  const NewsRepository();

  FutureResultData<List<Article>> getHeadlineNews({
    required int page,
    required String countryCode,
  });

  FutureResultVoid saveArticle({required Article article});

  FutureResultVoid unSaveArticle({required Article article});

  FutureResultData<List<Article>> getSavedArticles();

  FutureResultData<bool> isArticleSaved({required Article article});
}
