import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_saved_articles.dart';
import 'package:flutter_news_app/src/news/domain/usecases/save_article.dart';
import 'package:flutter_news_app/src/news/domain/usecases/unsave_article.dart';

part 'saved_articles_event.dart';

part 'saved_articles_state.dart';

class SavedArticlesBloc extends Bloc<SavedArticlesEvent, SavedArticlesState> {
  final GetSavedArticles _getSavedArticle;
  final SaveArticle _saveArticle;
  final UnSaveArticle _unSaveArticle;

  SavedArticlesBloc({
    required GetSavedArticles getSavedArticles,
    required SaveArticle saveArticle,
    required UnSaveArticle unSaveArticle,
  })  : _getSavedArticle = getSavedArticles,
        _saveArticle = saveArticle,
        _unSaveArticle = unSaveArticle,
        super(const SavedArticlesInitial()) {
    on<GetSavedArticlesEvent>(_getSavedArticlesHandler);
    on<SaveArticleEvent>(_saveArticleHandler);
    on<UnSaveArticleEvent>(_unSaveArticleHandler);
  }

  Future<void> _getSavedArticlesHandler(
    GetSavedArticlesEvent event,
    Emitter<SavedArticlesState> emit,
  ) async {
    emit(const LoadingSavedArticles());

    final result = await _getSavedArticle();
    result.fold(
      (failure) => emit(SavedArticlesLoadingError(failure.message)),
      (articles) => emit(SavedArticlesLoaded(articles)),
    );
  }

  Future<void> _saveArticleHandler(
    SaveArticleEvent event,
    Emitter<SavedArticlesState> emit,
  ) async {
    emit(const SavingArticle());

    final result = await _saveArticle(SaveArticleParams(
      article: event.article,
    ));

    result.fold(
      (failure) => emit(ArticleSavingError(failure.message)),
      (_) => emit(const ArticleSaved()),
    );
  }

  Future<void> _unSaveArticleHandler(
    UnSaveArticleEvent event,
    Emitter<SavedArticlesState> emit,
  ) async {
    emit(const UnSavingArticle());

    final result = await _unSaveArticle(UnSaveArticleParams(
      article: event.article,
    ));

    result.fold(
      (failure) => emit(ArticleUnSavingError(failure.message)),
      (_) => emit(const ArticleUnSaved()),
    );
  }
}
