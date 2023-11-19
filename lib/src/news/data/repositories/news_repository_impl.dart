import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/errors/exception.dart';
import 'package:flutter_news_app/core/errors/failure.dart';
import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/data/data_sources/news_remote_data_source.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/entities/category.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  FutureResultData<List<Article>> getHeadlineNews({
    required String categoryType,
    required int page,
    required String countryCode,
  }) async {
    try {
      final articles = await remoteDataSource.getHeadlineNews(
        categoryType: categoryType,
        page: page,
        countryCode: countryCode,
      );
      return Right(articles);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  FutureResultData<List<Category>> getNewsCategories() async {
    final List<Category> categories = [];
    categories.add(Category(
      name: 'Business',
      key: 'business',
      imagePath: 'assets/images/business.jpeg',
      isSelected: false,
    ));
    categories.add(Category(
      name: 'Entertainment',
      key: 'entertainment',
      imagePath: 'assets/images/entertainment.jpeg',
      isSelected: false,
    ));
    categories.add(Category(
      name: 'General',
      key: 'general',
      imagePath: 'assets/images/general.jpeg',
      isSelected: false,
    ));
    categories.add(Category(
      name: 'Health',
      key: 'health',
      imagePath: 'assets/images/health.jpeg',
      isSelected: false,
    ));
    categories.add(Category(
      name: 'Science',
      key: 'science',
      imagePath: 'assets/images/science.jpeg',
      isSelected: false,
    ));
    categories.add(Category(
      name: 'Sport',
      key: 'sport',
      imagePath: 'assets/images/sport.jpeg',
      isSelected: false,
    ));

    return Right(categories);
  }

  @override
  FutureResultData<List<Article>> getTrendingNews({
    required String categoryType,
    required int page,
    required String countryCode,
  }) async {
    try {
      final articles = await remoteDataSource.getTrendingNews(
        categoryType: categoryType,
        page: page,
        countryCode: countryCode,
      );
      return Right(articles);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
