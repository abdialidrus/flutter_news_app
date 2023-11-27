import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/saved_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/cubit/check_saved_article_cubit.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/article_detail_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late final WebViewController _controller;
  bool isArticleSaved = false;

  @override
  void initState() {
    super.initState();

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.article.url));

    _controller = controller;

    checkIsArticleSaved();
  }

  void checkIsArticleSaved() {
    context
        .read<CheckSavedArticleCubit>()
        .checkIsArticleSavedEvent(article: widget.article);
  }

  void saveOrUnSaveArticle() {
    if (isArticleSaved) {
      context.read<SavedArticlesBloc>().add(
        UnSaveArticleEvent(
          article: widget.article,
        ),
      );
    } else {
      context
          .read<SavedArticlesBloc>()
          .add(SaveArticleEvent(article: widget.article));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckSavedArticleCubit, CheckSavedArticleState>(
          listener: (context, state) {
            if (state is SavedArticleChecked) {
              isArticleSaved = state.isArticleSaved;
            }
          },
        ),
        BlocListener<SavedArticlesBloc, SavedArticlesState>(
          listener: (context, state) {
            if (state is ArticleSaved || state is ArticleUnSaved) {
              checkIsArticleSaved();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: ArticleDetailAppBar(
          article: widget.article,
          onToggleBookmark: () {
            saveOrUnSaveArticle();
          },
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
