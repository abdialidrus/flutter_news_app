import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/cubit/check_saved_article_cubit.dart';

class ArticleBookmark extends StatefulWidget {
  final Article article;

  const ArticleBookmark({super.key, required this.article});

  @override
  State<ArticleBookmark> createState() => _ArticleBookmarkState();
}

class _ArticleBookmarkState extends State<ArticleBookmark> {
  Widget getBookmarkWidget(CheckSavedArticleState state) {
    if (state is SavedArticleChecked) {
      if (state.isArticleSaved) {
        return const Icon(Icons.bookmark_rounded);
      } else {
        return const Icon(Icons.bookmark_border_rounded);
      }
    } else {
      return const Icon(Icons.bookmark_border_rounded);
    }
  }

  @override
  void initState() {
    super.initState();
    context
        .read<CheckSavedArticleCubit>()
        .checkIsArticleSavedEvent(article: widget.article);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckSavedArticleCubit, CheckSavedArticleState>(
      builder: (context, state) {
        return getBookmarkWidget(state);
      },
    );
  }
}
