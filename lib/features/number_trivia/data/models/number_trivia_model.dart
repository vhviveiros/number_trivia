import 'package:meta/meta.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({@required String text, @required int number})
      : super(text, number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    final model = NumberTriviaModel(
        text: json['text'], number: (json['number'] as num)?.toInt());
    if (model?.number == null) throw ServerException();
    return model;
  }

  Map<String, dynamic> toJson() => {"text": text, "number": number};
}
