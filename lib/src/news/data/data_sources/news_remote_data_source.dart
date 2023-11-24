import 'package:flutter_news_app/src/news/data/models/article_model.dart';
import 'package:flutter_news_app/src/news/data/models/category_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<CategoryModel>> getNewsCategories();

  Future<List<ArticleModel>> getHeadlineNews({
    required int page,
    required String countryCode,
  });

  Future<List<ArticleModel>> getTrendingNews({
    required String categoryType,
    required int page,
    required String countryCode,
  });
}
