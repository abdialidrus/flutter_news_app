import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/errors/exception.dart';
import 'package:flutter_news_app/core/errors/failure.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/data/data_sources/local/news_local_data_source.dart';
import 'package:flutter_news_app/src/news/data/data_sources/remote/news_remote_data_source.dart';
import 'package:flutter_news_app/src/news/data/models/article_entity.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  FutureResultData<List<Article>> getHeadlineNews({
    required int page,
    required int pageSize,
    required String countryCode,
  }) async {
    try {
      final articles = await remoteDataSource.getHeadlineNews(
        page: page,
        pageSize: pageSize,
        countryCode: countryCode,
      );
      return Right(articles.map((e) => e.toDomainEntity(countryCode)).toList());
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  FutureResultData<List<Article>> getSavedArticles() async {
    try {
      final articles = await localDataSource.getSavedArticles();
      return Right(articles.map((e) => e.toDomainEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  FutureResultVoid saveArticle({required Article article}) async {
    try {
      await localDataSource.saveArticle(
        articleEntity: ArticleEntity.fromEntity(article),
      );
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  FutureResultData<bool> isArticleSaved({required Article article}) async {
    try {
      final isArticleSaved = await localDataSource.checkIsArticleSaved(
        articleEntity: ArticleEntity.fromEntity(article),
      );
      return Right(isArticleSaved);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  FutureResultVoid unSaveArticle({required Article article}) async {
    try {
      await localDataSource.removeArticle(
        articleEntity: ArticleEntity.fromEntity(article),
      );
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
