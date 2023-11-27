import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class GetSavedArticles extends UseCaseWithoutParams<List<Article>> {
  final NewsRepository _repository;

  GetSavedArticles(this._repository);

  @override
  FutureResultData<List<Article>> call() async =>
      _repository.getSavedArticles();
}
