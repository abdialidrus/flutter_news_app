import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/usecase/usecase.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class CheckIsArticleSaved
    extends UseCaseWithParams<bool, CheckIsArticleSavedParams> {
  final NewsRepository _repository;

  CheckIsArticleSaved(this._repository);

  @override
  FutureResultData<bool> call(CheckIsArticleSavedParams params) async {
    return _repository.isArticleSaved(article: params.article);
  }
}

class CheckIsArticleSavedParams extends Equatable {
  final Article article;

  const CheckIsArticleSavedParams({required this.article});

  @override
  List<Object?> get props => [article];
}
