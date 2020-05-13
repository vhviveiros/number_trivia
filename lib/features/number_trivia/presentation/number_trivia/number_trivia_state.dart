part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  NumberTriviaState([List props]) : super(props);
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  Loaded(this.numberTrivia) : super([numberTrivia]);
}

class Error extends NumberTriviaState {
  final String message;

  Error(this.message) : super([message]);
}
