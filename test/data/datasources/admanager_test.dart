import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/utils/admanager.dart';

main() {
  AdManagerImpl adManagerDataSourceImpl;
  String topBanner;
  String bottomBanner;
  String testBanner;
  String fullBanner;

  setUp(() async {
    adManagerDataSourceImpl = AdManagerImpl();
    topBanner = AdManager.TOP_BANNER;
    bottomBanner = AdManager.BOTTOM_BANNER;
    testBanner = AdManager.TEST_BANNER;
    fullBanner = AdManager.FULL_BANNER;
  });

  group('get appId', () {
    test('should return the correct appId', () async {
      //act
      final result = adManagerDataSourceImpl.getAppid();
      //assert
      expect(result, equals("ca-app-pub-3782628728216687~8960937633"));
    });
  });

  group('get bannerId', () {
    test('should return the correct bottom_banner_id', () async {
      //act
      final result =
          adManagerDataSourceImpl.getBannerAdUnitId(bannerType: bottomBanner);
      //assert
      expect(result, equals("ca-app-pub-3782628728216687/6458897370"));
    });
    test('should return the correct top_banner_id', () async {
      //act
      final result =
          adManagerDataSourceImpl.getBannerAdUnitId(bannerType: topBanner);
      //assert
      expect(result, equals("ca-app-pub-3782628728216687/7143269561"));
    });
    test('should return the correct test_banner_id', () async {
      //act
      final result =
          adManagerDataSourceImpl.getBannerAdUnitId(bannerType: testBanner);
      //assert
      expect(result, equals("ca-app-pub-3940256099942544/6300978111"));
    });

    test('should return the correct full_banner_id', () async {
      //act
      final result =
          adManagerDataSourceImpl.getBannerAdUnitId(bannerType: fullBanner);
      //assert
      expect(result, equals("ca-app-pub-3782628728216687/4035961747"));
    });
  });
}
