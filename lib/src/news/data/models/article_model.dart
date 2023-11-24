import 'dart:convert';

import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/data/models/news_sources_api_model.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.title,
    required super.source,
    required super.url,
    required super.urlToImage,
    required super.description,
    required super.publishedAt,
  });

  ArticleModel.empty()
      : this(
          title: '_empty.title',
          source: '_empty.source',
          url: '_empty.url',
          urlToImage: '_empty.urlToImage',
          description: '_empty.description',
          publishedAt: '_empty.publishedAt',
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
        );

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(jsonDecode(source) as DataMap);

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
