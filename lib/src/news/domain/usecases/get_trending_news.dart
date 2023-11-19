import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class GetTrendingNews
    extends UseCaseWithParams<List<Article>, GetTrendingNewsParams> {
  final NewsRepository _repository;

  GetTrendingNews(this._repository);

  @override
  FutureResultData<List<Article>> call(GetTrendingNewsParams params) async =>
      _repository.getTrendingNews(
        categoryType: params.categoryType,
        page: params.page,
        countryCode: params.countryCode,
      );
}

class GetTrendingNewsParams extends Equatable {
  final String categoryType;
  final int page;
  final String countryCode;

  const GetTrendingNewsParams({
    required this.categoryType,
    required this.page,
    required this.countryCode,
  });

  @override
  List<Object?> get props => [categoryType, page];
}
