import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/container.dart';

import 'dispatch_controller.dart';

class InputNumber extends StatelessWidget {
  const InputNumber({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dispatchController = DispatchController.of(context);
    final _textController = _dispatchController.textController;
    final _focusNode = _dispatchController.focusNode;
    String inputStr;

    return MyContainer(
      child: TextField(
        focusNode: _focusNode,
        autofocus: true,
        controller: _textController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Discover a fact about some number :D',
        ),
        onChanged: (value) => inputStr = value,
        onSubmitted: (_) =>
            _dispatchController.dispatchConcrete(inputStr, context),
      ),
    );
  }
}
