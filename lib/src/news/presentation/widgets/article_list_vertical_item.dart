import 'package:cached_network_image/cached_network_image.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';

class ArticleListVerticalItem extends StatelessWidget {
  final Article article;
  final Function onItemSelected;
  final bool isSavedList;

  const ArticleListVerticalItem({
    super.key,
    required this.article,
    required this.onItemSelected,
    required this.isSavedList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemSelected();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 35),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isSavedList)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleFlag(
                      article.countryCode,
                      size: 18,
                    ),
                  ),
                Text(
                  article.source,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            Text(
              article.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  article.publishedAt,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
