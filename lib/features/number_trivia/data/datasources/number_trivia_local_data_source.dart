import 'dart:convert';

import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences _sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return _sharedPreferences.setString(CACHED_NUMBER_TRIVIA, json.encode(triviaToCache));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = _sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString == null) throw CacheException();
    return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
  }
}
