part of 'saved_articles_bloc.dart';

abstract class SavedArticlesState extends Equatable {
  const SavedArticlesState();

  @override
  List<Object> get props => [];
}

class SavedArticlesInitial extends SavedArticlesState {
  const SavedArticlesInitial();
}

class LoadingSavedArticles extends SavedArticlesState {
  const LoadingSavedArticles();
}

class SavingArticle extends SavedArticlesState {
  const SavingArticle();
}

class UnSavingArticle extends SavedArticlesState {
  const UnSavingArticle();
}

class SavedArticlesLoaded extends SavedArticlesState {
  final List<Article> articles;

  const SavedArticlesLoaded(this.articles);

  @override
  List<Object> get props => articles.map((article) => article.url).toList();
}

class ArticleSaved extends SavedArticlesState {
  const ArticleSaved();
}

class ArticleUnSaved extends SavedArticlesState {
  const ArticleUnSaved();
}

class SavedArticlesLoadingError extends SavedArticlesState {
  final String message;

  const SavedArticlesLoadingError(this.message);

  @override
  List<Object> get props => [message];
}

class ArticleSavingError extends SavedArticlesState {
  final String message;

  const ArticleSavingError(this.message);

  @override
  List<Object> get props => [message];
}

class ArticleUnSavingError extends SavedArticlesState {
  final String message;

  const ArticleUnSavingError(this.message);

  @override
  List<Object> get props => [message];
}
