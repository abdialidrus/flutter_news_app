import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/article_bookmark.dart';

class ArticleListVerticalItem extends StatefulWidget {
  final Article article;
  final Function onItemSelected;

  const ArticleListVerticalItem({
    super.key,
    required this.article,
    required this.onItemSelected,
  });

  @override
  State<ArticleListVerticalItem> createState() =>
      _ArticleListVerticalItemState();
}

class _ArticleListVerticalItemState extends State<ArticleListVerticalItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onItemSelected();
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
                imageUrl: widget.article.urlToImage,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              widget.article.source,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              widget.article.title,
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
                  widget.article.publishedAt,
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
