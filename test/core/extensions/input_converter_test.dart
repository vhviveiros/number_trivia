import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/extensions/input_converter.dart';

main() {
  group('stringTounsignedInt', () {
    test("should return an integer when the string represents an unsigned integer", () async {
      //arrange
      final str = "  123  ";
      //act
      final result = str.toUnsignedInteger();
      //assert
      expect(result, Left(123));
    });

    test("should return failure when the string doesn't represent an integer", () async {
      //arrange
      final str = 'abc';
      //act
      final result = str.toUnsignedInteger();
      //assert
      expect(result, Right(InvalidInputFailure()));
    });

    test("should return failure when the string is a negativa integer", () async {
      //arrange
      final str = '-123';
      //act
      final result = str.toUnsignedInteger();
      //assert
      expect(result, Right(InvalidInputFailure()));
    });
  });
}