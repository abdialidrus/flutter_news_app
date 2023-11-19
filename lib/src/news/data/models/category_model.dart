import 'package:flutter_news_app/src/news/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.name,
    required super.imagePath,
    required super.isSelected,
    required super.key,
  });
}
