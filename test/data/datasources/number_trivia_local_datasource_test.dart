import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final triviaCached = fixture('trivia_cached.json');
    final tNumberTrivia = NumberTrivia.fromJson(json.decode(triviaCached));

    test(
        "should return NumberTrivia from SharedPreferences when there's one in the cache",
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(triviaCached);
      //act
      final result = await dataSource.getLastNumberTrivia();
      //assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, tNumberTrivia);
    });

    test("should throw a cache exception when there's no cached value",
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = dataSource.getLastNumberTrivia;
      //assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test trivia');

    test("should call sharedPreferences to cache the data", () async {
      //act
      dataSource.cacheNumberTrivia(tNumberTrivia);
      //assert
      final jsonString = json.encode(tNumberTrivia.toJson());
      verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, jsonString));
    });
  });
}
