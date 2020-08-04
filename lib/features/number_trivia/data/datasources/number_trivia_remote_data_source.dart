import 'dart:convert';

import 'package:http/http.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Client _httpClient;

  NumberTriviaRemoteDataSourceImpl(this._httpClient);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getNumberTriviaFrom(number);

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getNumberTriviaFrom('random');

  Future<NumberTriviaModel> _getNumberTriviaFrom(dynamic typeSelector) async {
    final response = await _httpClient.get(
      'http://numbersapi.com/$typeSelector',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) throw ServerException();

    return NumberTriviaModel.fromJson(json.decode(response.body));
  }
}
