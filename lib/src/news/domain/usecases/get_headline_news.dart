import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class GetHeadlineNews
    extends UseCaseWithParams<List<Article>, GetHeadlineNewsParams> {
  final NewsRepository _repository;

  GetHeadlineNews(this._repository);

  @override
  FutureResultData<List<Article>> call(GetHeadlineNewsParams params) async =>
      _repository.getHeadlineNews(
        page: params.page,
        countryCode: params.countryCode,
      );
}

class GetHeadlineNewsParams extends Equatable {
  final int page;
  final String countryCode;

  const GetHeadlineNewsParams({
    required this.page,
    required this.countryCode,
  });

  @override
  List<Object?> get props => [countryCode, page];
}
