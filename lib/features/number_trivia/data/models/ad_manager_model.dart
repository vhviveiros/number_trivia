import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/ad_manager.dart';

class AdManagerModel extends AdManager {
  AdManagerModel({@required String appId, @required String bannerAdUnitId})
      : super(appId, bannerAdUnitId);
}
