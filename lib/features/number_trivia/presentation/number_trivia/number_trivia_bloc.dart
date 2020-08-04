import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/utils/equatable.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;

  NumberTriviaBloc(this._getConcreteNumberTrivia, this._getRandomNumberTrivia,
      this._inputConverter)
      : assert(_getRandomNumberTrivia != null),
        assert(_getConcreteNumberTrivia != null),
        assert(_inputConverter != null);

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForConcreteNumber) {
      final result =
          _inputConverter.stringToUnsignedInteger(event.numberString);
      yield* result.fold(
        (value) async* {
          yield Loading();
          final failureOrTrivia =
              await _getConcreteNumberTrivia.call(Params(value));
          yield _eitherLoadedOrErrorState(failureOrTrivia);
        },
        (failure) async* {
          yield Error(failure.message);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await _getRandomNumberTrivia.call(NoParams());
      yield _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  NumberTriviaState _eitherLoadedOrErrorState(
      Either<NumberTrivia, Failure> failureOrTrivia) {
    var fold = failureOrTrivia.fold(
      (trivia) => Loaded(trivia),
      (failure) => Error(_mapFailureToMessage(failure)),
    );
    return fold;
  }

  String _mapFailureToMessage(Failure failure) => failure.message;
}
