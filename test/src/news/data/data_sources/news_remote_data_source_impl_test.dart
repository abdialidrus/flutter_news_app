import 'package:flutter_news_app/src/news/data/data_sources/remote/news_remote_data_source.dart';
import 'package:flutter_news_app/src/news/data/data_sources/remote/news_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late NewsRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    //remoteDataSource = NewsRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });
}
