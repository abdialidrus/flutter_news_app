import 'dart:convert';

import 'package:flutter_news_app/core/utils/typedef.dart';
import 'package:flutter_news_app/src/news/data/models/article_model.dart';

class NewsApiModel {
  final String status;
  final int totalResult;
  final List<ArticleModel> articles;

  NewsApiModel({
    required this.status,
    required this.totalResult,
    required this.articles,
  });

  factory NewsApiModel.fromJson(DataMap json) {
    return NewsApiModel(status: json['status'] as String,
      totalResult: json['totalResults'] as int,
      articles: List<DataMap>.from(json['articles'] as List)
          .map((article) => ArticleModel.fromMap(article))
          .toList(),
    );
  }
}
