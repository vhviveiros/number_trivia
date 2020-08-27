import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:number_trivia/core/error/failures.dart';
part 'usecase.freezed.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Type, Failure>> call(Params params);
}

@freezed
abstract class NoParams with _$NoParams {
  const factory NoParams() = _NoParams;
}
