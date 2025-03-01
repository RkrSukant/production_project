import 'package:flutter/cupertino.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/categories_repository.dart';
import 'package:furnihome_ar/feature/categories/data/local/categories_local.dart';
import 'package:furnihome_ar/feature/categories/data/remote/categories_remote.dart';
import 'package:furnihome_ar/feature/categories/model/category_model.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemote remote = locator<CategoriesRemote>();
  final CategoriesLocal local = locator<CategoriesLocal>();

  @override
  Future<List<CategoryModel>> getCategoryList() async {
    dynamic response = remote.getCategoryList();
    debugPrint(response.toString());
    return response;
  }

  @override
  Future<List<FurnitureModel>> getCategoryFurnitureList(String categoryName) {
    return remote.getCategoryFurnitureList(categoryName);
  }
}
