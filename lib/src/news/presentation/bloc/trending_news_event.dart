part of 'trending_news_bloc.dart';

abstract class TrendingNewsEvent extends Equatable {
  const TrendingNewsEvent();

  @override
  List<Object?> get props => [];
}

class GetTrendingNewsEvent extends TrendingNewsEvent {
  final String categoryType;
  final int page;
  final String countryCode;

  const GetTrendingNewsEvent({
    required this.categoryType,
    required this.page,
    required this.countryCode,
  });
}
