import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/domain/entities/category.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/news_categories_bloc.dart';

class SectionNewsCategories extends StatelessWidget {
  final Function(Category category) onCategorySelected;

  const SectionNewsCategories({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: BlocConsumer<NewsCategoriesBloc, NewsCategoriesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is LoadingNewsCategories
              ? const CircularProgressIndicator()
              : state is NewsCategoriesLoaded
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onCategorySelected(state.categories[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    state.categories[index].imagePath,
                                    width: 120,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.black38,
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.categories[index].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink();
        },
      ),
    );
  }
}
