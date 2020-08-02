import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/container.dart';

import 'my_theme.dart';

class TriviaDisplay extends StatelessWidget {
  final String message;

  const TriviaDisplay({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      height: MyTheme.of(context).displayHeight,
      child: Center(
        child: SingleChildScrollView(
          child: SelectableText(
            message,
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Roboto',
                color: Color.fromRGBO(114, 114, 114, 1)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
