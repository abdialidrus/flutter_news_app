part of 'trending_news_bloc.dart';

abstract class TrendingNewsState extends Equatable {
  const TrendingNewsState();

  @override
  List<Object> get props => [];
}

class TrendingNewsInitial extends TrendingNewsState {
  const TrendingNewsInitial();
}

class LoadingTrendingNews extends TrendingNewsState {
  const LoadingTrendingNews();
}

class TrendingNewsLoaded extends TrendingNewsState {
  final List<Article> articles;
  const TrendingNewsLoaded(this.articles);

  @override
  List<Object> get props => articles.map((article) => article.url).toList();
}

class TrendingNewsError extends TrendingNewsState {
  final String message;

  const TrendingNewsError(this.message);

  @override
  List<Object> get props => [message];
}