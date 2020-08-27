import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
part 'number_trivia_state.freezed.dart';

@freezed
abstract class NumberTriviaState with _$NumberTriviaState {
  const factory NumberTriviaState.empty() = _Empty;
  const factory NumberTriviaState.loading() = _Loading;
  const factory NumberTriviaState.loaded(NumberTrivia numberTrivia) = _Loaded;
  const factory NumberTriviaState.error(String message) = _Error;
}
