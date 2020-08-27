import 'dart:convert';

import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTrivia> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences _sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache) {
    return _sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, json.encode(triviaToCache));
  }

  @override
  Future<NumberTrivia> getLastNumberTrivia() {
    final jsonString = _sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString == null) throw CacheException();
    return Future.value(NumberTrivia.fromJson(json.decode(jsonString)));
  }
}
