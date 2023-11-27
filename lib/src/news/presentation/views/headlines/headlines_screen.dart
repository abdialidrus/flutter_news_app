import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/headline_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/saved_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/views/article_detail_screen.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/article_list_vertical_item.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/main_app_bar.dart';

class HeadlinesScreen extends StatefulWidget {
  const HeadlinesScreen({super.key});

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  String _countryCode = 'us';
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setupScrollController();
    getHeadlineNews(false);
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          getHeadlineNews(false);
        }
      }
    });
  }

  void getHeadlineNews(bool loadFirstPage) {
    BlocProvider.of<HeadlineNewsBloc>(context).add(
      GetHeadlineNewsEvent(
        page: loadFirstPage ? 1 : 0,
        countryCode: _countryCode,
      ),
    );
  }

  void updateCountryState(String newCode) {
    BlocProvider.of<HeadlineNewsBloc>(context).add(
      UpdateNewsSourceEvent(
        countryCode: newCode,
      ),
    );
  }

  void updateCountry(String code) {
    if (code == _countryCode) {
      return;
    }

    setState(() {
      _countryCode = code.toLowerCase();
    });

    getHeadlineNews(true);
  }

  void saveArticle(Article article) {
    context.read<SavedArticlesBloc>().add(
          SaveArticleEvent(
            article: article,
          ),
        );
  }

  void onArticleSelected(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(
          article: article,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onCountrySelected: (String code) {
          updateCountryState(code);
        },
        countryCode: _countryCode,
      ),
      body: BlocConsumer<HeadlineNewsBloc, HeadlineNewsState>(
        listener: (context, state) {
          if (state is NewsSourceUpdated) {
            updateCountry(state.countryCode);
          }
          if (state is LoadingHeadlineNews) {
            updateCountry(state.countryCode);
          }
        },
        builder: (context, state) {
          if (state is LoadingHeadlineNews && state.isFirstFetch) {
            return _loadingIndicator();
          }

          List<Article> articles = [];
          bool isLoading = false;

          if (state is LoadingHeadlineNews) {
            articles = state.oldArticles;
            isLoading = true;
          } else if (state is HeadlineNewsLoaded) {
            articles = state.articles;
          }

          if (articles.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      'assets/images/empty_headlines.png',
                    ),
                    width: 220,
                    fit: BoxFit.fitHeight,
                  ),
                  Text('No headlines available'),
                ],
              ),
            );
          }

          return ListView.builder(
            key: const PageStorageKey(0),
            controller: scrollController,
            itemCount: articles.length + (isLoading ? 1 : 0),
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (index < articles.length) {
                return ArticleListVerticalItem(
                  article: articles[index],
                  onItemSelected: () {
                    onArticleSelected(articles[index]);
                  },
                );
              } else {
                Timer(const Duration(milliseconds: 30), () {
                  scrollController.jumpTo(
                    scrollController.position.maxScrollExtent,
                  );
                });
                return _loadingIndicator();
              }
            },
          );
        },
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
