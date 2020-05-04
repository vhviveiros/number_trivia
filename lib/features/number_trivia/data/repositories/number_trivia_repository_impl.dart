import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:number_trivia/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../datasources/number_trivia_remote_data_source.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<NumberTrivia, Failure>> getConcreteNumberTrivia(
      int number) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteTrivia =
            await remoteDataSource.getConcreteNumberTrivia(number);
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Left(remoteTrivia);
      }
    } on ServerException {
      return Right(ServerFailure());
    }
  }

  @override
  Future<Either<NumberTrivia, Failure>> getRandomNumberTrivia() {
    return null;
  }
}
