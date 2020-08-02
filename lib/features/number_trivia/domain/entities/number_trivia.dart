import 'package:number_trivia/core/utils/equatable.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia(this.text, this.number) : super([text, number]);
}