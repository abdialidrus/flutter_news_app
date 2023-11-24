import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String source;
  final String url;
  final String urlToImage;
  final String description;
  final String publishedAt;

  const Article({
    required this.title,
    required this.source,
    required this.url,
    required this.urlToImage,
    required this.description,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        title,
        source,
        url,
        urlToImage,
        description,
        publishedAt,
      ];
}
