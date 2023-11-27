import 'dart:convert';

import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';

class ArticleModel {
  final String title;
  final String source;
  final String url;
  final String urlToImage;
  final String description;
  final String publishedAt;

  ArticleModel({
    required this.title,
    required this.source,
    required this.url,
    required this.urlToImage,
    required this.description,
    required this.publishedAt,
  });

  ArticleModel.fromMap(DataMap map)
      : this(
          title: map['title'] as String,
          // source: map['author'] as String? ?? 'Unknown author',
          source: map['source']['name'] as String? ??
              map['author'] as String? ??
              'Source unknown',
          url: map['url'] as String,
          urlToImage: map['urlToImage'] as String? ?? '',
          description:
              map['description'] as String? ?? 'no description available',
          publishedAt: map['publishedAt'] as String,
        );

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(jsonDecode(source) as DataMap);

  Article toDomainEntity(String countryCode) {
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

  DataMap toMap() => {
        'title': title,
        'source': source,
        'url': url,
        'urlToImage': urlToImage,
        'description': description,
        'publishedAt': publishedAt,
      };

  String toJson() => jsonEncode(toMap());
}
