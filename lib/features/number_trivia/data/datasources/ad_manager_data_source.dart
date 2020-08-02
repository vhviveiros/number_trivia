import 'dart:io';

import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/data/models/ad_manager_model.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/ad_manager_repository.dart';

abstract class AdManagerDataSource {
  AdManagerModel getAdManagerModel({@required String bannerType});
  AdManagerModel getTestAdManagerModel();
}

class AdManagerDataSourceImpl extends AdManagerDataSource {
  final _bannerIds = {
    AdManagerRepository.TOP_BANNER: 'ca-app-pub-3782628728216687/7143269561',
    AdManagerRepository.BOTTOM_BANNER: 'ca-app-pub-3782628728216687/6458897370',
    AdManagerRepository.TEST_BANNER: 'ca-app-pub-3940256099942544/6300978111',
  };

  @override
  AdManagerModel getAdManagerModel({@required String bannerType}) {
    if (Platform.isAndroid) {
      return AdManagerModel(
        appId: _bannerIds[bannerType],
        bannerAdUnitId: "ca-app-pub-3782628728216687/6458897370",
      );
    } else if (Platform.isIOS) {
      throw new UnsupportedError("Unsupported platform");
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  @override
  AdManagerModel getTestAdManagerModel() =>
      getAdManagerModel(bannerType: 'test_banner');
}
