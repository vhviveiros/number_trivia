import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/controller/dispatch_controller.dart';

class TriviaControls extends StatelessWidget {
  const TriviaControls({
    Key key,
    @required double width,
  })  : _width = width,
        super(key: key);

  final double _width;

  @override
  Widget build(BuildContext context) {
    final controller = DispatchController.of(context);
    final blackColor = Color.fromRGBO(54, 53, 53, 1);

    return SizedBox(
      width: _width,
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            height: 50,
            child: RaisedButton(
              color: blackColor,
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
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: blackColor),
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
