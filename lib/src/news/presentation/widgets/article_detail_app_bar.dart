import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/article_bookmark.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Article article;
  final Function() onToggleBookmark;

  const ArticleDetailAppBar({
    super.key,
    required this.article,
    required this.onToggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ArticleBookmark(article: article),
          ),
          onTap: () {
            onToggleBookmark();
          },
        ),
        GestureDetector(
          child: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.share_rounded),
          ),
          onTap: () async {
            final result = await Share.shareWithResult(article.url);
            if (result.status == ShareResultStatus.success) {}
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
