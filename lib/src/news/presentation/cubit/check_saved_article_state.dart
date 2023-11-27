part of 'check_saved_article_cubit.dart';

abstract class CheckSavedArticleState extends Equatable {
  const CheckSavedArticleState();

  @override
  List<Object> get props => [];
}

class CheckSavedArticleInitial extends CheckSavedArticleState {
  const CheckSavedArticleInitial();
}

class CheckingSaveArticle extends CheckSavedArticleState {
  const CheckingSaveArticle();
}

class SavedArticleChecked extends CheckSavedArticleState {
  final bool isArticleSaved;

  const SavedArticleChecked(this.isArticleSaved);

  @override
  List<Object> get props => [isArticleSaved];
}

class SavedArticleCheckError extends CheckSavedArticleState {
  final String message;

  const SavedArticleCheckError(this.message);

  @override
  List<Object> get props => [message];
}
