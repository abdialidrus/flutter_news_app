part of 'headline_news_bloc.dart';

abstract class HeadlineNewsEvent extends Equatable {
  const HeadlineNewsEvent();

  @override
  List<Object?> get props => [];
}

class GetHeadlineNewsEvent extends HeadlineNewsEvent {
  final int page;
  final String countryCode;

  const GetHeadlineNewsEvent({
    required this.page,
    required this.countryCode,
  });
}
