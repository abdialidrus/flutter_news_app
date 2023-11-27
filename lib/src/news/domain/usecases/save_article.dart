import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class SaveArticle extends UseCaseWithParams<void, SaveArticleParams> {
  final NewsRepository _repository;

  SaveArticle(this._repository);

  @override
  FutureResultData<void> call(SaveArticleParams params) async =>
      _repository.saveArticle(
        article: params.article,
      );
}

class SaveArticleParams extends Equatable {
  final Article article;

  const SaveArticleParams({required this.article});

  @override
  List<Object?> get props => [article];
}
