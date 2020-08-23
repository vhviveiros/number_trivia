import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/utils/admanager.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/display_ads.dart';
import 'package:number_trivia/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  MaterialApp triviaPage;

  SharedPreferences.setMockInitialValues({});

  await Injector.setup();

  triviaPage = MaterialApp(
    home: Scaffold(
      body: NumberTriviaPage(),
    ),
  );

  group('Display ads', () {
    testWidgets("Top banner should use the release id values",
        (WidgetTester tester) async {
      await tester.pumpWidget(triviaPage);

      final topBanner =
          tester.firstElement(find.byType(DisplayAds)).widget as DisplayAds;

      expect(topBanner.bannerType, AdManager.TOP_BANNER);
      expect(topBanner.admobBannerSize, AdmobBannerSize.BANNER);
    });

    testWidgets("Bottom banner should use the release id values",
        (WidgetTester tester) async {
      await tester.pumpWidget(triviaPage);

      final topBanner = tester
          .elementList(find.byType(DisplayAds))
          .elementAt(1)
          .widget as DisplayAds;

      expect(topBanner.bannerType, AdManager.BOTTOM_BANNER);
      expect(topBanner.admobBannerSize, AdmobBannerSize.LARGE_BANNER);
    });
  });
}
