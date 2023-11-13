import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/category.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class GetNewsCategories extends UseCaseWithoutParams<List<Category>> {
  final NewsRepository _repository;

  GetNewsCategories(this._repository);

  @override
  FutureResultData<List<Category>> call() async =>
      _repository.getNewsCategories();
}
