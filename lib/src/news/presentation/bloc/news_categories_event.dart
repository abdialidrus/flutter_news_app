part of 'news_categories_bloc.dart';

abstract class NewsCategoriesEvent extends Equatable {
  const NewsCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class GetNewsCategoriesEvent extends NewsCategoriesEvent {
  const GetNewsCategoriesEvent();
}
