import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

const SERVER_FAILURE_MESSAGE = "Server Failure";
const CACHE_FAILURE_MESSAGE = "Cache Failure";
const INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid input - the number must be a positive integer";

@freezed
abstract class Failure with _$Failure {
  const factory Failure(String message) = _Failure;
  factory Failure.serverFailure() => Failure(SERVER_FAILURE_MESSAGE);
  factory Failure.cacheFailure() => Failure(CACHE_FAILURE_MESSAGE);
  factory Failure.invalidInputFailure() =>
      Failure(INVALID_INPUT_FAILURE_MESSAGE);
}
