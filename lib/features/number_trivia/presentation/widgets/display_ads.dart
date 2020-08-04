import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:number_trivia/core/utils/admanager.dart';
import 'package:number_trivia/injector.dart';

class DisplayAds extends StatelessWidget {
  final AdmobBannerSize admobBannerSize;
  final String bannerType;

  const DisplayAds({
    Key key,
    @required this.admobBannerSize,
    @required this.bannerType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Injector.resolve<AdManager>();

    return AdmobBanner(
        adUnitId: repository.getBannerAdUnitId(bannerType: bannerType),
        adSize: admobBannerSize,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          switch (event) {
            case AdmobAdEvent.loaded:
              print('Admob banner loaded!');
              break;

            case AdmobAdEvent.opened:
              print('Admob banner opened!');
              break;

            case AdmobAdEvent.closed:
              print('Admob banner closed!');
              break;

            case AdmobAdEvent.failedToLoad:
              print(
                  'Admob banner failed to load. Error code: ${args['errorCode']}');
              break;
          }
        });
  }
}
