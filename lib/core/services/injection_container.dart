import 'package:flutter_news_app/src/news/data/data_sources/local/article_database.dart';
import 'package:flutter_news_app/src/news/data/data_sources/local/news_local_data_source.dart';
import 'package:flutter_news_app/src/news/data/data_sources/local/news_local_data_source_impl.dart';
import 'package:flutter_news_app/src/news/data/data_sources/remote/news_remote_data_source.dart';
import 'package:flutter_news_app/src/news/data/data_sources/remote/news_remote_data_source_impl.dart';
import 'package:flutter_news_app/src/news/data/repositories/news_repository_impl.dart';
import 'package:flutter_news_app/src/news/data/util/dio_config.dart';
import 'package:flutter_news_app/src/news/domain/repositories/news_repository.dart';
import 'package:flutter_news_app/src/news/domain/usecases/check_is_article_saved.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_headline_news.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_saved_articles.dart';
import 'package:flutter_news_app/src/news/domain/usecases/save_article.dart';
import 'package:flutter_news_app/src/news/domain/usecases/unsave_article.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/headline_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/saved_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/cubit/check_saved_article_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App logic
    ..registerFactory(() => HeadlineNewsBloc(getHeadlineNews: sl()))
    ..registerFactory(() => SavedArticlesBloc(
          getSavedArticles: sl(),
          saveArticle: sl(),
          unSaveArticle: sl(),
        ))
    ..registerFactory(() => CheckSavedArticleCubit(checkIsArticleSaved: sl()))
    ..registerLazySingleton(() => GetHeadlineNews(sl()))
    ..registerLazySingleton(() => GetSavedArticles(sl()))
    ..registerLazySingleton(() => SaveArticle(sl()))
    ..registerLazySingleton(() => UnSaveArticle(sl()))
    ..registerLazySingleton(() => CheckIsArticleSaved(sl()))

    // Repositories
    ..registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
          remoteDataSource: sl(),
          localDataSource: sl(),
        ))

    // Data sources
    ..registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(sl()))
    ..registerLazySingleton<NewsLocalDataSource>(
        () => NewsLocalDataSourceImpl(sl()))

    // External
    ..registerSingleton(getDio())
    ..registerSingleton(ArticleDatabase());
}
