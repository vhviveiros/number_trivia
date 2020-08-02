import 'dart:io';

import 'package:flutter/material.dart';

abstract class AdManager {
  String getAppid();
  String getBannerAdUnitId({@required String bannerType});

  static const TOP_BANNER = 'top_banner';
  static const BOTTOM_BANNER = 'bottom_banner';
  static const TEST_BANNER = 'test_banner';
}

class AdManagerImpl extends AdManager {
  final _bannerIds = {
    AdManager.TOP_BANNER: 'ca-app-pub-3782628728216687/7143269561',
    AdManager.BOTTOM_BANNER: 'ca-app-pub-3782628728216687/6458897370',
    AdManager.TEST_BANNER: 'ca-app-pub-3940256099942544/6300978111',
  };

  @override
  String getAppid() => "ca-app-pub-3782628728216687~8960937633";

  @override
  String getBannerAdUnitId({String bannerType}) {
    if (Platform.isAndroid) {
      return _bannerIds[bannerType];
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
