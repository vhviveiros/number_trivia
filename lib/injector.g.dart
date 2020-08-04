// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void _configureNumberTriviaDataSourceFactories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => NumberTriviaBloc(
        c<GetConcreteNumberTrivia>(),
        c<GetRandomNumberTrivia>(),
        c<InputConverter>()));
    container.registerSingleton(
        (c) => GetConcreteNumberTrivia(c<NumberTriviaRepository>()));
    container.registerSingleton(
        (c) => GetRandomNumberTrivia(c<NumberTriviaRepository>()));
    container.registerSingleton((c) => InputConverter());
    container.registerSingleton<NumberTriviaRepository>((c) =>
        NumberTriviaRepositoryImpl(
            remoteDataSource: c<NumberTriviaRemoteDataSource>(),
            localDataSource: c<NumberTriviaLocalDataSource>(),
            networkInfo: c<NetworkInfo>()));
    container.registerSingleton<NumberTriviaRemoteDataSource>(
        (c) => NumberTriviaRemoteDataSourceImpl(c<Client>()));
    container.registerSingleton<NetworkInfo>(
        (c) => NetworkInfoImpl(c<DataConnectionChecker>()));
    container.registerSingleton((c) => Client());
    container.registerSingleton((c) => DataConnectionChecker());
    container.registerSingleton<NumberTriviaLocalDataSource>(
        (c) => NumberTriviaLocalDataSourceImpl(c<SharedPreferences>()));
  }

  void _configureAdManagerFactories() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton<AdManager>((c) => AdManagerImpl());
  }
}
