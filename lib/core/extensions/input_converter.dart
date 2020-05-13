import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';

extension InputConvverter on String {
  Either<int, Failure> toUnsignedInteger() {
    try {
      final value = int.parse(this);
      if (value < 0) throw FormatException();
      return Left(value);
    } on FormatException {
      return Right(InvalidInputFailure());
    }
  }
}
