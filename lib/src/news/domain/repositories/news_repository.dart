import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/entities/category.dart';

abstract class NewsRepository {
  const NewsRepository();

  FutureResultData<List<Category>> getNewsCategories();
  FutureResultData<List<Article>> getHeadlineNews();
  FutureResultData<List<Article>> getTrendingNews();
}