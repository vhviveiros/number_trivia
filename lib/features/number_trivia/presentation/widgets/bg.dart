import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        height: size.height * 0.4,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'lib/features/number_trivia/presentation/img/bg.png',
            ),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: size.height * 0.6,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 236, 236, 1),
              Color.fromRGBO(118, 118, 118, 0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    ]);
  }
}
