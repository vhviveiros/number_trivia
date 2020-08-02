import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/my_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 6,
          )
        ],
      ),
      height: MyTheme.of(context).displayHeight,
      width: MyTheme.of(context).width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
