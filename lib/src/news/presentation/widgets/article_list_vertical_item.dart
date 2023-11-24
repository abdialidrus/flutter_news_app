import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ArticleListVerticalItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String url;
  final String source;
  final String publishedAt;
  final Function onItemSelected;

  const ArticleListVerticalItem({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.desc,
    required this.url,
    required this.source,
    required this.publishedAt,
    required this.onItemSelected,
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
                imageUrl: imgUrl,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              source,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  publishedAt,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                GestureDetector(
                  child: const Icon(Icons.bookmark_border_rounded), // unsaved
                  // child: const Icon(Icons.bookmark_added_rounded), // saved
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
