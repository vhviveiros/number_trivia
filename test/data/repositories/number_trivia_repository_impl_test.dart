import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

class MockRemoteDataState extends Mock implements NumberTriviaRemoteDataSource {
}

class MockLocalDataState extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

main(List<String> args) {
  NumberTriviaRepositoryImpl repo;
  MockRemoteDataState remote;
  MockLocalDataState local;
  MockNetworkInfo netInfo;

  setUp(() {
    local = MockLocalDataState();
    remote = MockRemoteDataState();
    netInfo = MockNetworkInfo();
    repo = NumberTriviaRepositoryImpl(
        remoteDataSource: remote, localDataSource: local, networkInfo: netInfo);
  });
}
