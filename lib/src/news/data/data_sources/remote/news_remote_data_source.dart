import 'package:flutter_news_app/src/news/data/models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getHeadlineNews({
    required int page,
    required String countryCode,
  });
}
