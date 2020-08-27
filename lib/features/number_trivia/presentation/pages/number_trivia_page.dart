import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/core/utils/admanager.dart';
import 'package:number_trivia/features/number_trivia/presentation/number_trivia/number_trivia_cubit.dart';
import 'package:number_trivia/features/number_trivia/presentation/number_trivia/number_trivia_state.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:number_trivia/injector.dart';

class NumberTriviaPage extends StatelessWidget {
  NumberTriviaPage({Key key}) : super(key: key);

  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return DispatchController(
      textController,
      focusNode,
      child: Scaffold(
        body: MyTheme(
          displayHeight: MediaQuery.of(context).size.height / 2.2,
          width: MediaQuery.of(context).size.width * 0.85,
          insets: EdgeInsets.only(bottom: 4, top: 4, left: 8, right: 8),
          spacing: 32,
          child: BlocProvider<NumberTriviaCubit>(
            create: (context) => Injector.resolve<NumberTriviaCubit>(),
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
                          bannerType: AdManager.TOP_BANNER,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<NumberTriviaCubit, NumberTriviaState>(
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
                          bannerType: AdManager.BOTTOM_BANNER,
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
    return state.when(
      empty: () => TriviaDisplay(
        message: "Start searching!",
      ),
      loading: () => LoadingWidget(),
      loaded: (numberTrivia) => TriviaDisplay(
        message: numberTrivia.text,
      ),
      error: (error) => TriviaDisplay(
        message: error,
      ),
    );
  }
}
