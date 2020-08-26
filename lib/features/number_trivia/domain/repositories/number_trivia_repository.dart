import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<NumberTrivia, Failure>> getConcreteNumberTrivia(int number);
  Future<Either<NumberTrivia, Failure>> getRandomNumberTrivia();
}
