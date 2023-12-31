part of 'headline_news_bloc.dart';

abstract class HeadlineNewsState extends Equatable {
  const HeadlineNewsState();

  @override
  List<Object> get props => [];
}

class HeadlineNewsInitial extends HeadlineNewsState {
  const HeadlineNewsInitial();
}

class LoadingHeadlineNews extends HeadlineNewsState {
  final List<Article> oldArticles;
  final bool isFirstFetch;
  final String countryCode;

  const LoadingHeadlineNews(
    this.oldArticles, {
    this.isFirstFetch = false,
    required this.countryCode,
  });
}

class HeadlineNewsLoaded extends HeadlineNewsState {
  final List<Article> articles;

  const HeadlineNewsLoaded(this.articles);

  @override
  List<Object> get props => articles.map((article) => article.url).toList();
}

class HeadlineNewsError extends HeadlineNewsState {
  final String message;

  const HeadlineNewsError(this.message);

  @override
  List<Object> get props => [message];
}

class NewsSourceUpdated extends HeadlineNewsState {
  final String countryCode;

  const NewsSourceUpdated(this.countryCode);

  @override
  List<Object> get props => [countryCode];
}
