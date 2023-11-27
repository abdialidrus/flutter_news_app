import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/saved_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/views/article_detail_screen.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/article_list_vertical_item.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/main_app_bar.dart';

class SavedArticlesScreen extends StatefulWidget {
  const SavedArticlesScreen({super.key});

  @override
  State<SavedArticlesScreen> createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen> {
  @override
  void initState() {
    super.initState();
    getSavedArticles();
  }

  @override
  void didUpdateWidget(covariant SavedArticlesScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void getSavedArticles() {
    context.read<SavedArticlesBloc>().add(const GetSavedArticlesEvent());
  }

  void onArticleSelected(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(
          article: article,
        ),
      ),
    ).then((value) => getSavedArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onCountrySelected: (String code) {},
        countryCode: null,
      ),
      body: BlocConsumer<SavedArticlesBloc, SavedArticlesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is LoadingSavedArticles
              ? const Center(child: CircularProgressIndicator())
              : state is SavedArticlesLoadingError
                  ? Center(child: Text(state.message))
                  : state is SavedArticlesLoaded
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: state.articles.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final article = state.articles[index];
                                  return ArticleListVerticalItem(
                                    article: article,
                                    onItemSelected: (article) {
                                      onArticleSelected(article);
                                    },
                                    isSavedList: true,
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
