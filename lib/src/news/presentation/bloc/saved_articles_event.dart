part of 'saved_articles_bloc.dart';

abstract class SavedArticlesEvent extends Equatable {
  const SavedArticlesEvent();

  @override
  List<Object?> get props => [];
}

class GetSavedArticlesEvent extends SavedArticlesEvent {
  const GetSavedArticlesEvent();
}

class SaveArticleEvent extends SavedArticlesEvent {
  final Article article;

  const SaveArticleEvent({required this.article});

}

class UnSaveArticleEvent extends SavedArticlesEvent {
  final Article article;

  const UnSaveArticleEvent({required this.article});
}
