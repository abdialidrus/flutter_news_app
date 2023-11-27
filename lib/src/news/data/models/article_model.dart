import 'dart:convert';

import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required super.title,
    required super.source,
    required super.url,
    required super.urlToImage,
    required super.description,
    required super.publishedAt,
    required super.isSaved,
  });

  ArticleModel.empty()
      : this(
          title: '_empty.title',
          source: '_empty.source',
          url: '_empty.url',
          urlToImage: '_empty.urlToImage',
          description: '_empty.description',
          publishedAt: '_empty.publishedAt',
          isSaved: false,
        );

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
          isSaved: false,
        );

  ArticleModel.fromMapDb(DataMap map)
      : this(
          title: map['title'] as String,
          source: map['source'] as String? ?? 'Source unknown',
          url: map['url'] as String,
          urlToImage: map['url_to_image'] as String? ?? '',
          description:
              map['description'] as String? ?? 'no description available',
          publishedAt: map['published_at'] as String,
          isSaved: true,
        );

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(jsonDecode(source) as DataMap);

  ArticleModel.fromEntity(Article article) : this(
        title: article.title,
        source: article.source,
        url: article.url,
        urlToImage: article.urlToImage,
        description: article.description,
        publishedAt: article.publishedAt,
        isSaved: article.isSaved,
      );

  DataMap toMap() => {
        'title': title,
        'source': source,
        'url': url,
        'urlToImage': urlToImage,
        'description': description,
        'publishedAt': publishedAt,
      };

  DataMap toMapForDb() => {
        'title': title,
        'source': source,
        'url': url,
        'url_to_image': urlToImage,
        'description': description,
        'published_at': publishedAt,
      };

  String toJson() => jsonEncode(toMap());
}
