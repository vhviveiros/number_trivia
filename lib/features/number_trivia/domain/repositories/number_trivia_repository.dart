import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<NumberTrivia, Failure>> getConcreteNumberTrivia(int number);
  Future<Either<NumberTrivia, Failure>> getRandomNumberTrivia();
}