import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/article_list_vertical_item.dart';

class ArticleListVertical extends StatelessWidget {
  final List<Article> articles;
  final Function(String url) onItemSelected;

  const ArticleListVertical({
    super.key,
    required this.articles,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: articles.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleListVerticalItem(
          imgUrl: article.urlToImage,
          title: article.title,
          desc: article.description,
          url: article.url,
          source: article.source,
          publishedAt: article.publishedAt,
          onItemSelected: () {
            onItemSelected(article.url);
          },
        );
      },
    );
  }
}
