import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/errors/exception.dart';
import 'package:flutter_news_app/core/utils/constants.dart';
import 'package:flutter_news_app/src/news/data/data_sources/news_remote_data_source.dart';
import 'package:flutter_news_app/src/news/data/models/article_model.dart';
import 'package:flutter_news_app/src/news/data/models/category_model.dart';
import 'package:flutter_news_app/src/news/data/models/news_api_model.dart';
import 'package:flutter_news_app/src/news/data/models/news_sources_api_model.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio _dio;

  const NewsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ArticleModel>> getHeadlineNews({
    required String categoryType,
    required int page,
    required String countryCode,
  }) async {
    try {
      final response = await _dio.get(
        kGetHeadlineNewsEndpoint,
        queryParameters: {
          'country': countryCode,
          'pageSize': 10,
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

  @override
  Future<List<CategoryModel>> getNewsCategories() {
    // TODO: implement getNewsCategories
    throw UnimplementedError();
  }

  @override
  Future<List<ArticleModel>> getTrendingNews({
    required String categoryType,
    required int page,
    required String countryCode,
  }) async {
    try {
      final sourcesResponse = await _dio.get(
        kGetNewsSources,
        queryParameters: {
          'country': countryCode,
        },
      );

      if (sourcesResponse.statusCode != 200) {
        throw APIException(
          message: sourcesResponse.statusMessage ?? 'Unknown Error',
          statusCode: sourcesResponse.statusCode ?? 505,
        );
      }

      final sourceResponseBody =
          NewsSourcesApiModel.fromJson(sourcesResponse.data);

      // if (sourceResponseBody.sources.isEmpty) {
      //   throw const APIException(
      //     message: 'No news sources available for this country',
      //     statusCode: 505,
      //   );
      // }

      final newsSources =
          sourceResponseBody.sources.map((source) => source.id).toList();
      final sourcesParams = newsSources.join(',');

      final kQueryParameters = {
        'q': categoryType,
        'sortBy': 'popularity',
        'pageSize': 10,
        'page': page,
      };

      if (sourceResponseBody.sources.isNotEmpty) {
        kQueryParameters['sources'] = sourcesParams;
      }

      final response = await _dio.get(
        kGetTrendingNewsEndpoint,
        queryParameters: kQueryParameters,
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
