import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_headline_news.dart';

part 'headline_news_event.dart';

part 'headline_news_state.dart';

class HeadlineNewsBloc extends Bloc<HeadlineNewsEvent, HeadlineNewsState> {
  final GetHeadlineNews _getHeadlineNews;

  HeadlineNewsBloc({
    required GetHeadlineNews getHeadlineNews,
  })  : _getHeadlineNews = getHeadlineNews,
        super(const HeadlineNewsInitial()) {
    on<GetHeadlineNewsEvent>(_getHeadlineNewsHandler);
  }

  Future<void> _getHeadlineNewsHandler(
    GetHeadlineNewsEvent event,
    Emitter<HeadlineNewsState> emit,
  ) async {
    emit(const LoadingHeadlineNews());

    final result = await _getHeadlineNews(GetHeadlineNewsParams(
      categoryType: event.categoryType,
      page: event.page,
      countryCode: event.countryCode,
    ));

    result.fold(
      (failure) => emit(HeadlineNewsError(failure.message)),
      (articles) => emit(HeadlineNewsLoaded(articles)),
    );
  }
}
