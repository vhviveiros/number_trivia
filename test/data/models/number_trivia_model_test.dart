import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../fixtures/fixture_reader.dart';

main() {
  final tNumberTrivia = NumberTrivia(text: "test", number: 1);

  test('should be a subclass of NumberTrivia model', () async {
    //assert
    expect(tNumberTrivia, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid value when json number is a integer', () async {
      //arrange
      final jsonMap = json.decode(fixture('trivia.json'));
      //act
      final result = NumberTrivia.fromJson(jsonMap);
      //assert
      expect(result, tNumberTrivia);
    });

    test('should return a valid value when json number is a double', () async {
      //arrange
      final jsonMap = json.decode(fixture('trivia_double.json'));
      //act
      final result = NumberTrivia.fromJson(jsonMap);
      //assert
      expect(result, tNumberTrivia);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //act
      final result = tNumberTrivia.toJson();
      //assert
      expect(result, {
        "text": "test",
        "number": 1.0,
      });
    });
  });
}
