import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      mockGetConcreteNumberTrivia,
      mockGetRandomNumberTrivia,
      mockInputConverter,
    );
  });

  test('initial state should be empty', () async => {expect(bloc.initialState, Empty())});

  group('get trivia for concrete number', () {
    final tNumberString = '1';
    final tNumberParsed = int.parse(tNumberString);

    test("should call the InputConverter to validate and convert the string to an unsigned integer",
        () async {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any)).thenReturn(Left(tNumberParsed));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any)).thenReturn(Right(InvalidInputFailure()));
        // assert later
        final expected = [
          // The initial state is always emitted first
          Empty(),
          Error(INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
      },
    );
  });
}
