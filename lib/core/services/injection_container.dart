import 'package:dio/dio.dart';
import 'package:flutter_news_app/src/news/data/data_sources/news_remote_data_source.dart';
import 'package:flutter_news_app/src/news/data/data_sources/news_remote_data_source_impl.dart';
import 'package:flutter_news_app/src/news/data/repositories/news_repository_impl.dart';
import 'package:flutter_news_app/src/news/data/util/dio_config.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_headline_news.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_news_categories.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_trending_news.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/headline_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/news_categories_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/trending_news_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App logic
    ..registerFactory(() => HeadlineNewsBloc(getHeadlineNews: sl()))
    ..registerFactory(() => NewsCategoriesBloc(getNewsCategories: sl()))
    ..registerFactory(() => TrendingNewsBloc(getTrendingNews: sl()))
    ..registerLazySingleton(() => GetNewsCategories(sl()))
    ..registerLazySingleton(() => GetHeadlineNews(sl()))
    ..registerLazySingleton(() => GetTrendingNews(sl()))

    // Repositories
    ..registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(remoteDataSource: sl()))

    // Data sources
    ..registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(sl()))

    // External
    ..registerSingleton(getDio());
}
