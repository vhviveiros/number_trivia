import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/ad_manager_data_source.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/ad_manager.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/ad_manager_repository.dart';

class AdManagerRepositoryImpl extends AdManagerRepository {
  final AdManagerDataSource adManagerDataSource;

  AdManagerRepositoryImpl({@required this.adManagerDataSource});

  @override
  AdManager getAdManager({@required String bannerType}) =>
      adManagerDataSource.getAdManagerModel(bannerType: bannerType);

  @override
  AdManager getTestAdManager() => adManagerDataSource.getTestAdManagerModel();
}
