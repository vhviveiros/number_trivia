import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_theme.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({Key key, this.child, this.height, this.width})
      : super(key: key);
  final Widget child;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final myTheme = MyTheme.of(context);

    return Container(
      child: Container(
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
        width: width != null ? width : myTheme.width,
        height: height,
        child: myTheme.padding(child: child),
      ),
    );
  }
}
