import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/ad_manager_repository.dart';
import 'package:number_trivia/features/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:number_trivia/injector.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyTheme(
        displayHeight: MediaQuery.of(context).size.height / 2.2,
        width: MediaQuery.of(context).size.width * 0.85,
        insets: EdgeInsets.only(bottom: 4, top: 4, left: 8, right: 8),
        spacing: 32,
        child: BlocProvider<NumberTriviaBloc>(
          create: (context) => Injector.resolve<NumberTriviaBloc>(),
          child: DispatchController(
            TextEditingController(),
            FocusNode(),
            child: Stack(children: [
              BackGround(),
              SingleChildScrollView(
                child: Center(
                  child: Builder(
                    builder: (context) {
                      final myTheme = MyTheme.of(context);
                      return Column(children: [
                        SizedBox(
                          height: 24,
                        ),
                        DisplayAds(
                          admobBannerSize: AdmobBannerSize.BANNER,
                          bannerType: AdManagerRepository.TOP_BANNER,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                          // ignore: missing_return
                          builder: (context, state) =>
                              _getTriviaDisplay(state, context),
                        ),
                        myTheme.spacingBox(),
                        InputNumber(),
                        myTheme.spacingBox(),
                        TriviaControls(width: myTheme.width),
                        SizedBox(height: 12),
                        DisplayAds(
                          admobBannerSize: AdmobBannerSize.LARGE_BANNER,
                          bannerType: AdManagerRepository.BOTTOM_BANNER,
                        ),
                      ]);
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  StatelessWidget _getTriviaDisplay(
      NumberTriviaState state, BuildContext context) {
    if (state is Empty)
      return TriviaDisplay(
        message: "Start searching!",
      );
    else if (state is Loading)
      return LoadingWidget();
    else if (state is Loaded)
      return TriviaDisplay(
        message: state.numberTrivia.text,
      );
    else if (state is Error)
      return TriviaDisplay(
        message: state.message,
      );
  }
}
