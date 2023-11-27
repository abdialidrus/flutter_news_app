import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class UnSaveArticle extends UseCaseWithParams<void, UnSaveArticleParams> {
  final NewsRepository _repository;

  UnSaveArticle(this._repository);

  @override
  FutureResultData<void> call(UnSaveArticleParams params) async =>
      _repository.unSaveArticle(
        article: params.article,
      );
}

class UnSaveArticleParams extends Equatable {
  final Article article;

  const UnSaveArticleParams({required this.article});

  @override
  List<Object?> get props => [article];
}
