import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid input - the number must be a positive integer";

class NumberTriviaCubit extends Cubit<NumberTriviaState> {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;

  NumberTriviaCubit(this._getConcreteNumberTrivia, this._getRandomNumberTrivia,
      this._inputConverter)
      : assert(_getRandomNumberTrivia != null),
        assert(_getConcreteNumberTrivia != null),
        assert(_inputConverter != null),
        super(NumberTriviaState.empty());

  Future<void> getTriviaForConcreteNumber(String numberString) async {
    final result = _inputConverter.stringToUnsignedInteger(numberString);
    await result.fold(
      (value) async {
        emit(NumberTriviaState.loading());
        final concreteTrivia =
            await _getConcreteNumberTrivia.call(Params(value));
        emit(_eitherLoadedOrErrorState(concreteTrivia));
      },
      (failure) {
        emit(NumberTriviaState.error(INVALID_INPUT_FAILURE_MESSAGE));
      },
    );
  }

  Future<void> getTriviaForRandomNumber() async {
    emit(NumberTriviaState.loading());
    final failureOrTrivia = await _getRandomNumberTrivia.call(NoParams());
    emit(_eitherLoadedOrErrorState(failureOrTrivia));
  }

  NumberTriviaState _eitherLoadedOrErrorState(
      Either<NumberTrivia, Failure> failureOrTrivia) {
    var fold = failureOrTrivia.fold(
      (trivia) => NumberTriviaState.loaded(trivia),
      (failure) => NumberTriviaState.error(failure.message),
    );
    return fold;
  }
}
