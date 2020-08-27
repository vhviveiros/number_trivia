import 'dart:convert';

import 'package:http/http.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTrivia> getConcreteNumberTrivia(int number);

  Future<NumberTrivia> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Client _httpClient;

  NumberTriviaRemoteDataSourceImpl(this._httpClient);

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) =>
      _getNumberTriviaFrom(number);

  @override
  Future<NumberTrivia> getRandomNumberTrivia() =>
      _getNumberTriviaFrom('random');

  Future<NumberTrivia> _getNumberTriviaFrom(dynamic typeSelector) async {
    final response = await _httpClient.get(
      'http://numbersapi.com/$typeSelector',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) throw ServerException();

    final numberTrivia = NumberTrivia.fromJson(json.decode(response.body));

    if (numberTrivia.number == null) throw ServerException();

    return numberTrivia;
  }
}
