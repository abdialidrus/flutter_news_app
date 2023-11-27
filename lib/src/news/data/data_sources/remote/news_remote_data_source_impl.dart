import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/errors/exception.dart';
import 'package:flutter_news_app/core/utils/constants.dart';
import 'package:flutter_news_app/src/news/data/data_sources/remote/news_remote_data_source.dart';
import 'package:flutter_news_app/src/news/data/models/article_model.dart';
import 'package:flutter_news_app/src/news/data/models/news_api_model.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio _dio;

  const NewsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ArticleModel>> getHeadlineNews({
    required int page,
    required int pageSize,
    required String countryCode,
  }) async {
    try {
      final response = await _dio.get(
        kGetHeadlineNewsEndpoint,
        queryParameters: {
          'country': countryCode,
          'pageSize': pageSize,
          'page': page,
        },
      );

      if (response.statusCode != 200) {
        throw APIException(
          message: response.statusMessage ?? 'Unknown Error',
          statusCode: response.statusCode ?? 505,
        );
      }

      final responseBody = NewsApiModel.fromJson(response.data);

      return responseBody.articles;
    } on APIException {
      rethrow;
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
