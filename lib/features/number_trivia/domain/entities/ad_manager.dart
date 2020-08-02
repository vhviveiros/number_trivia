import 'package:number_trivia/core/utils/equatable.dart';

class AdManager extends Equatable {
  final String appId;
  final String bannerAdUnitId;

  AdManager(this.appId, this.bannerAdUnitId) : super([appId, bannerAdUnitId]);
}
