import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';

class ArticleEntity {
  final String title;
  final String source;
  final String url;
  final String urlToImage;
  final String description;
  final String publishedAt;
  final String countryCode;

  ArticleEntity({
    required this.title,
    required this.source,
    required this.url,
    required this.urlToImage,
    required this.description,
    required this.publishedAt,
    required this.countryCode,
  });

  Article toDomainEntity() {
    return Article(
      title: title,
      source: source,
      url: url,
      urlToImage: urlToImage,
      description: description,
      publishedAt: publishedAt,
      countryCode: countryCode,
    );
  }

  ArticleEntity.fromEntity(Article article)
      : this(
          title: article.title,
          source: article.source,
          url: article.url,
          urlToImage: article.urlToImage,
          description: article.description,
          publishedAt: article.publishedAt,
          countryCode: article.countryCode,
        );

  ArticleEntity.fromDb(DataMap map)
      : this(
          title: map['title'] as String,
          source: map['source'] as String? ?? 'Source unknown',
          url: map['url'] as String,
          urlToImage: map['url_to_image'] as String? ?? '',
          description:
              map['description'] as String? ?? 'no description available',
          publishedAt: map['published_at'] as String,
          countryCode: map['country_code'] as String,
        );

  DataMap toMapForDb() => {
        'title': title,
        'source': source,
        'url': url,
        'url_to_image': urlToImage,
        'description': description,
        'published_at': publishedAt,
        'country_code': countryCode,
      };
}
