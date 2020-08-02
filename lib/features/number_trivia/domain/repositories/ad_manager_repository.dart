import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/ad_manager.dart';

abstract class AdManagerRepository {
  AdManager getAdManager({@required String bannerType});
  AdManager getTestAdManager();

  static const TOP_BANNER = 'top_banner';
  static const BOTTOM_BANNER = 'bottom_banner';
  static const TEST_BANNER = 'test_banner';
}
