import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/news_list_item.dart';

class TrendingNewsList extends StatelessWidget {
  final List<Article> articles;

  const TrendingNewsList({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: articles.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return NewsListItem(
          imgUrl: articles[index].urlToImage,
          title: articles[index].title,
          desc: articles[index].description,
          url: articles[index].url,
        );
      },
    );
  }
}
