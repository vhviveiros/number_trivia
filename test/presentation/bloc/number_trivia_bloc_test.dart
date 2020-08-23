import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/number_trivia/number_trivia_cubit.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

main() {
  NumberTriviaCubit cubit;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    cubit = NumberTriviaCubit(
      mockGetConcreteNumberTrivia,
      mockGetRandomNumberTrivia,
      mockInputConverter,
    );
  });

  test('initial state should be empty',
      () async => {expect(cubit.state, Empty())});

  group('get trivia for concrete number', () {
    final tNumberString = '1';
    final tNumberParsed = int.parse(tNumberString);
    final tNumberTrivia = NumberTrivia('test trivia', 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(tNumberParsed));

    test(
        "should call the InputConverter to validate and convert the string to an unsigned integer",
        () async {
      setUpMockInputConverterSuccess();
      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(InvalidInputFailure()));
        // assert later
        final expected = [
          // The initial state is always emitted first
          Error(INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(cubit, emitsInOrder(expected));
        // act
        cubit.getTriviaForConcreteNumber(tNumberString);
      },
    );

    test("should get data from the concrete use case", () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(tNumberTrivia));
      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
      await untilCalled(mockGetConcreteNumberTrivia(any));
      //assert
      verify(mockGetConcreteNumberTrivia(Params(tNumberParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(tNumberTrivia));

      //assert later
      final expected = [
        Loading(),
        Loaded(tNumberTrivia),
      ];

      expectLater(cubit, emitsInOrder(expected));

      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(ServerFailure()));

      //assert later
      final expected = [
        Loading(),
        Error(SERVER_FAILURE_MESSAGE),
      ];

      expectLater(cubit, emitsInOrder(expected));

      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
    });

    test('should emit [Loading, Error] with a proper message for the error',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(CacheFailure()));

      //assert later
      final expected = [
        Loading(),
        Error(CACHE_FAILURE_MESSAGE),
      ];

      expectLater(cubit, emitsInOrder(expected));

      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
    });
  });

  group('get trivia for random number', () {
    final tNumberTrivia = NumberTrivia('test trivia', 1);

    test("should get data from the random use case", () async {
      //arrange
      when(mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => Left(tNumberTrivia));
      //act
      cubit.getTriviaForRandomNumber();
      await untilCalled(mockGetRandomNumberTrivia(any));
      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(tNumberTrivia));

      //assert later
      final expected = [
        Loading(),
        Loaded(tNumberTrivia),
      ];

      expectLater(cubit, emitsInOrder(expected));

      //act
      cubit.getTriviaForRandomNumber();
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(ServerFailure()));

      //assert later
      final expected = [
        Loading(),
        Error(SERVER_FAILURE_MESSAGE),
      ];

      expectLater(cubit, emitsInOrder(expected));

      //act
      cubit.getTriviaForRandomNumber();
    });

    test('should emit [Loading, Error] with a proper message for the error',
        () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(CacheFailure()));

      //assert later
      final expected = [
        Loading(),
        Error(CACHE_FAILURE_MESSAGE),
      ];

      expectLater(cubit, emitsInOrder(expected));

      //act
      cubit.getTriviaForRandomNumber();
    });
  });
}
