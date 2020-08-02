import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTheme extends InheritedWidget {
  MyTheme(
      {@required this.width,
      @required this.displayHeight,
      @required this.insets,
      @required this.spacing,
      Key key,
      this.child})
      : super(key: key, child: child);

  final Widget child;
  final EdgeInsetsGeometry insets;
  final double spacing;
  final double width;
  final double displayHeight;

  static MyTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyTheme>();
  }

  SizedBox spacingBox() => SizedBox(height: spacing);

  Padding padding({Widget child}) => Padding(padding: insets, child: child);

  @override
  bool updateShouldNotify(MyTheme oldWidget) => true;
}
