import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/domain/usecases/check_is_article_saved.dart';

part 'check_saved_article_state.dart';

class CheckSavedArticleCubit extends Cubit<CheckSavedArticleState> {
  final CheckIsArticleSaved _checkIsArticleSaved;

  CheckSavedArticleCubit({
    required CheckIsArticleSaved checkIsArticleSaved,
  })  : _checkIsArticleSaved = checkIsArticleSaved,
        super(const CheckSavedArticleInitial());

  Future<void> checkIsArticleSavedEvent({
    required Article article,
  }) async {
    emit(const CheckingSaveArticle());

    final result = await _checkIsArticleSaved(
      CheckIsArticleSavedParams(
        article: article,
      ),
    );

    result.fold(
      (failure) => emit(SavedArticleCheckError(failure.message)),
      (isSaved) => emit(SavedArticleChecked(isSaved)),
    );
  }
}
