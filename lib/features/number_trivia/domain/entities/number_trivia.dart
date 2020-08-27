import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_trivia.freezed.dart';
part 'number_trivia.g.dart';

@freezed
abstract class NumberTrivia implements _$NumberTrivia {
  const factory NumberTrivia({String text, num number}) = _NumberTrivia;
  factory NumberTrivia.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaFromJson(json);
}
