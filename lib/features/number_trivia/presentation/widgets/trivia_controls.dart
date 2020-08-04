import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/controller/dispatch_controller.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
    @required double width,
  })  : _width = width,
        super(key: key);

  final double _width;

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  @override
  Widget build(BuildContext context) {
    final controller = DispatchController.of(context);

    return SizedBox(
      width: widget._width,
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            height: 50,
            child: RaisedButton(
              color: Color.fromRGBO(54, 53, 53, 1),
              child: Text("Search".toUpperCase()),
              textTheme: ButtonTextTheme.primary,
              onPressed: () => controller.dispatchConcrete(
                  controller.textController.text, context),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: RaisedButton(
                child: Text(
                  "Random Number".toUpperCase(),
                  textAlign: TextAlign.center,
                ),
                color: Colors.white,
                textTheme: ButtonTextTheme.primary,
                onPressed: () => controller.dispatchRandom(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
