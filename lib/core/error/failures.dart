import 'package:number_trivia/core/utils/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  static const String SERVER_FAILURE_MESSAGE = "Server Failure";
  static const String CACHE_FAILURE_MESSAGE = "Cache Failure";
  static const String INVALID_INPUT_FAILURE_MESSAGE =
      "Invalid input - the number must be a positive integer";

  Failure(this.message) : super([message]);
}

//General Failures
class ServerFailure extends Failure {
  ServerFailure() : super(Failure.SERVER_FAILURE_MESSAGE);
}

class CacheFailure extends Failure {
  CacheFailure() : super(Failure.CACHE_FAILURE_MESSAGE);
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure() : super(Failure.INVALID_INPUT_FAILURE_MESSAGE);
}
