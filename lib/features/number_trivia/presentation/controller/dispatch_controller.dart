import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';

class DispatchController extends InheritedWidget {
  final TextEditingController textController;
  final FocusNode focusNode;

  const DispatchController(this.textController, this.focusNode, {child})
      : super(child: child);

  static DispatchController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DispatchController>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  void dispatchConcrete(String inputStr, BuildContext context) {
    textController.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputStr));
    focusNode.requestFocus();
  }

  void dispatchRandom(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
