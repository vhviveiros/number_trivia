import 'package:dartz/dartz.dart';

import '../extensions/equatable.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Type, Failure>> call(Params params);
}

class NoParams extends Equatable {
  NoParams() : super([]);
}
