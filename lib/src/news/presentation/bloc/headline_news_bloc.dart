import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_headline_news.dart';

part 'headline_news_event.dart';

part 'headline_news_state.dart';

class HeadlineNewsBloc extends Bloc<HeadlineNewsEvent, HeadlineNewsState> {
  final GetHeadlineNews _getHeadlineNews;
  String newsSource = 'us';

  final int pageSize = 10;
  int currentPage = 1;
  Set<Article> currentArticles = {};

  HeadlineNewsBloc({
    required GetHeadlineNews getHeadlineNews,
  })  : _getHeadlineNews = getHeadlineNews,
        super(const HeadlineNewsInitial()) {
    on<GetHeadlineNewsEvent>(_getHeadlineNewsHandler);
    on<UpdateNewsSourceEvent>(_updateNewsSourceHandler);
  }

  Future<void> _updateNewsSourceHandler(
    UpdateNewsSourceEvent event,
    Emitter<HeadlineNewsState> emit,
  ) async {
    newsSource = event.countryCode;
    emit(NewsSourceUpdated(newsSource));
  }

  Future<void> _getHeadlineNewsHandler(
    GetHeadlineNewsEvent event,
    Emitter<HeadlineNewsState> emit,
  ) async {
    if (state is LoadingHeadlineNews) return;

    final currentState = state;
    if (currentState is HeadlineNewsLoaded) {
      currentArticles.clear();
      for (var element in currentState.articles) {
        currentArticles.add(element);
      }
    }

    emit(LoadingHeadlineNews(
      currentArticles.toList(),
      countryCode: newsSource,
      isFirstFetch: currentPage == 1,
    ));

    if (event.page == 1) {
      currentPage = 1;
      currentArticles.clear();
    }

    final result = await _getHeadlineNews(GetHeadlineNewsParams(
      page: currentPage,
      pageSize: pageSize,
      countryCode: newsSource,
    ));

    result.fold(
      (failure) => emit(HeadlineNewsError(failure.message)),
      (articles) {
        if (articles.length == pageSize) {
          currentPage++;
        }
        currentArticles.addAll(articles);
        emit(HeadlineNewsLoaded(currentArticles.toList()));
      },
    );
  }
}
