import 'package:dio/dio.dart';
import 'package:flutter_news_app/src/news/data/util/request_interceptors.dart';

Dio getDio() {
  final dio = Dio();

  dio.interceptors.add(RequestInterceptors());

  return dio;
}