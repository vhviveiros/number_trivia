import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:number_trivia/core/utils/admanager.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:number_trivia/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.setup();
  Admob.initialize(Injector.resolve<AdManager>().getAppid());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(
        AssetImage('lib/features/number_trivia/presentation/img/bg.png'),
        context);
    return MaterialApp(
      title: 'Number Trivia',
      home: NumberTriviaPage(),
    );
  }
}
