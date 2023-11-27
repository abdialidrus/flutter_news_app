import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/errors/failure.dart';

typedef FutureResultData<T> = Future<Either<Failure, T>>;

typedef FutureResultVoid = FutureResultData<void>;

typedef DataMap = Map<String, dynamic>;