import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/domain/entities/category.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/trending_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/section_header.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/trending_news_list.dart';

class SectionNewsTrending extends StatefulWidget {
  final Category selectedCategory;

  const SectionNewsTrending({super.key, required this.selectedCategory});

  @override
  State<SectionNewsTrending> createState() => _SectionNewsTrendingState();
}

class _SectionNewsTrendingState extends State<SectionNewsTrending> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<TrendingNewsBloc, TrendingNewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is LoadingTrendingNews
              ? const CircularProgressIndicator()
              : state is TrendingNewsError
                  ? Text(state.message)
                  : state is TrendingNewsLoaded
                      ? Column(
                          children: [
                            SectionHeader(
                              title: 'Trending news',
                              onViewAllPressed: () {},
                            ),
                            TrendingNewsList(articles: state.articles)
                          ],
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
