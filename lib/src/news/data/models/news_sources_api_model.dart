import 'package:flutter_news_app/core/utils/typedef.dart';

class NewsSourcesApiModel {
  final String status;
  final List<NewsSource> sources;

  NewsSourcesApiModel({required this.status, required this.sources});

  factory NewsSourcesApiModel.fromJson(DataMap json) {
    return NewsSourcesApiModel(
        status: json['status'],
        sources: List<DataMap>.from(json['sources'] as List)
            .map((source) => NewsSource.fromJson(source))
            .toList());
  }
}

class NewsSource {
  final String? id;
  final String? name;

  NewsSource({required this.id, required this.name});

  NewsSource.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
        );

  factory NewsSource.fromJson(DataMap json) {
    return NewsSource(id: json['id'], name: json['name']);
  }
}
