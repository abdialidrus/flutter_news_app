import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/news/domain/entities/category.dart';
import 'package:flutter_news_app/src/news/domain/usecases/get_news_categories.dart';

part 'news_categories_event.dart';

part 'news_categories_state.dart';

class NewsCategoriesBloc
    extends Bloc<NewsCategoriesEvent, NewsCategoriesState> {
  final GetNewsCategories _getNewsCategories;

  NewsCategoriesBloc({
    required GetNewsCategories getNewsCategories,
  })  : _getNewsCategories = getNewsCategories,
        super(const NewsCategoriesInitial()) {
    on<GetNewsCategoriesEvent>(_getNewsCategoriesHandler);
  }

  Future<void> _getNewsCategoriesHandler(
    GetNewsCategoriesEvent event,
    Emitter<NewsCategoriesState> emit,
  ) async {
    emit(const LoadingNewsCategories());

    final result = await _getNewsCategories();

    result.fold(
      (failure) => emit(NewsCategoriesError(failure.message)),
      (categories) => emit(NewsCategoriesLoaded(categories)),
    );
  }
}
