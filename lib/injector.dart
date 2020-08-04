import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container;
  static final resolve = container.resolve;

  static Future<void> setup() async {
    container = KiwiContainer();
    await _$Injector()._configure();
  }

  Future<void> _configure() async {
    await _configureNumberTriviaDataSourceModule();
  }

  //! NumberTriviaLocalDataSource
  Future<void> _configureNumberTriviaDataSourceModule() async {
    await _configureNumberTriviaDataSourceInstances();
    _configureNumberTriviaDataSourceFactories();
  }

  Future<void> _configureNumberTriviaDataSourceInstances() async {
    container.registerInstance<SharedPreferences>(
        await SharedPreferences.getInstance());
  }

  @Register.factory(NumberTriviaBloc)
  @Register.singleton(GetConcreteNumberTrivia)
  @Register.singleton(GetRandomNumberTrivia)
  @Register.singleton(InputConverter)
  @Register.singleton(NumberTriviaRepository, from: NumberTriviaRepositoryImpl)
  @Register.singleton(NumberTriviaRemoteDataSource,
      from: NumberTriviaRemoteDataSourceImpl)
  @Register.singleton(NetworkInfo, from: NetworkInfoImpl)
  @Register.singleton(Client)
  @Register.singleton(DataConnectionChecker)
  @Register.singleton(NumberTriviaLocalDataSource,
      from: NumberTriviaLocalDataSourceImpl)
  void _configureNumberTriviaDataSourceFactories();
}
