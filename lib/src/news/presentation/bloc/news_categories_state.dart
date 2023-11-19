part of 'news_categories_bloc.dart';

abstract class NewsCategoriesState extends Equatable {
  const NewsCategoriesState();

  @override
  List<Object> get props => [];
}

class NewsCategoriesInitial extends NewsCategoriesState {
  const NewsCategoriesInitial();
}

class LoadingNewsCategories extends NewsCategoriesState {
  const LoadingNewsCategories();
}

class NewsCategoriesLoaded extends NewsCategoriesState {
  final List<Category> categories;

  const NewsCategoriesLoaded(this.categories);

  @override
  List<Object> get props =>
      categories.map((category) => category.name).toList();
}

class NewsCategoriesError extends NewsCategoriesState {
  final String message;

  const NewsCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
