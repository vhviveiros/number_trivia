import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/number_trivia/number_trivia_cubit.dart';

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
    BlocProvider.of<NumberTriviaCubit>(context)
        .getTriviaForConcreteNumber(inputStr);
    focusNode.requestFocus();
  }

  void dispatchRandom(BuildContext context) {
    BlocProvider.of<NumberTriviaCubit>(context).getTriviaForRandomNumber();
  }
}
