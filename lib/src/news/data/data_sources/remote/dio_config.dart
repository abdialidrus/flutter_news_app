import 'package:dio/dio.dart';
import 'package:flutter_news_app/src/news/data/data_sources/remote/request_interceptors.dart';

Dio getDio() {
  final dio = Dio();

  dio.interceptors.add(RequestInterceptors());

  return dio;
}