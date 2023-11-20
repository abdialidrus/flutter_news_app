import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/news_list_item.dart';

class TrendingNewsList extends StatelessWidget {
  final List<Article> articles;
  final Function(String url) onNewsSelected;

  const TrendingNewsList({
    super.key,
    required this.articles,
    required this.onNewsSelected,
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
        return NewsListItem(
          imgUrl: article.urlToImage,
          title: article.title,
          desc: article.description,
          url: article.url,
          onNewsSelected: () {
            onNewsSelected(article.url);
          },
        );
      },
    );
  }
}
