import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client {}

main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  final jsonString = fixture('trivia.json');

  void setupMockHttpClientResponse200({customJson}) {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response(customJson ?? jsonString, 200));
  }

  void setupMockHttpClientResponse404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('Something went wrong', 404));
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(mockHttpClient);
  });

  group('get concrete number trivia', () {
    final tNumber = 1;

    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(jsonString));

    test(
        "should perform a GET on a URL with a number being the endpoint with json header",
        () async {
      //arrange
      setupMockHttpClientResponse200();
      //act
      dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockHttpClient.get(
        'http://numbersapi.com/$tNumber',
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test("should return numberTrivia when response code is 200 (success)",
        () async {
      //arrange
      setupMockHttpClientResponse200();
      //act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });

    test("should throw a ServerException when the response is different of 200",
        () async {
      //arrange
      setupMockHttpClientResponse404();
      //act
      final call = dataSource.getConcreteNumberTrivia;
      //assert
      expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
    });

    test('should throw a ServerException when the response is null', () async {
      //arrange
      setupMockHttpClientResponse200(customJson: fixture('trivia_null.json'));
      //act
      final call = dataSource.getConcreteNumberTrivia;
      //assert
      expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('get random number trivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(jsonString));

    test(
        "should perform a GET on a URL with a number being the endpoint with json header",
        () async {
      //arrange
      setupMockHttpClientResponse200();
      //act
      dataSource.getRandomNumberTrivia();
      //assert
      verify(mockHttpClient.get(
        'http://numbersapi.com/random',
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test("should return numberTrivia when response code is 200 (success)",
        () async {
      //arrange
      setupMockHttpClientResponse200();
      //act
      final result = await dataSource.getRandomNumberTrivia();
      //assert
      expect(result, equals(tNumberTriviaModel));
    });

    test("should throw a ServerException when the response is different of 200",
        () async {
      //arrange
      setupMockHttpClientResponse404();
      //act
      final call = dataSource.getRandomNumberTrivia;
      //assert
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });

    test('should throw a ServerException when the response is null', () async {
      //arrange
      setupMockHttpClientResponse200(customJson: fixture('trivia_null.json'));
      //act
      final call = dataSource.getRandomNumberTrivia;
      //assert
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
