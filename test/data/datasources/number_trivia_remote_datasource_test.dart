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

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(mockHttpClient);
  });

  group('get concrete number trivia', () {
    final tNumber = 1;
    final jsonString = fixture('trivia.json');
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(jsonString));
    void setupMockHttpClientResponse200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response(jsonString, 200));
    }
    void setupMockHttpClientResponse404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('Something went wrong', 404));
    }

    test("should perform a GET on a URL with a number being the endpoint with json header", () async {
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

    test("should return numberTrivia when response code is 200 (success)", () async {
      //arrange
      setupMockHttpClientResponse200();
      //act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });

    test("should throw a ServerException when the response is different of 200", () async {
      //arrange
      setupMockHttpClientResponse404();
      //act
      final call = dataSource.getConcreteNumberTrivia;
      //assert
      expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
