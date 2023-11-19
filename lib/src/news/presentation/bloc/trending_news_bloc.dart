import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_trending_news.dart';

part 'trending_news_event.dart';

part 'trending_news_state.dart';

class TrendingNewsBloc extends Bloc<TrendingNewsEvent, TrendingNewsState> {
  final GetTrendingNews _getTrendingNews;

  TrendingNewsBloc({
    required GetTrendingNews getTrendingNews,
  })  : _getTrendingNews = getTrendingNews,
        super(const TrendingNewsInitial()) {
    on<GetTrendingNewsEvent>(_getTrendingNewsHandler);
  }

  Future<void> _getTrendingNewsHandler(
    GetTrendingNewsEvent event,
    Emitter<TrendingNewsState> emit,
  ) async {
    emit(const LoadingTrendingNews());

    final result = await _getTrendingNews(GetTrendingNewsParams(
      categoryType: event.categoryType,
      page: event.page,
      countryCode: event.countryCode,
    ));

    result.fold(
      (failure) => emit(TrendingNewsError(failure.message)),
      (articles) => emit(TrendingNewsLoaded(articles)),
    );
  }
}
