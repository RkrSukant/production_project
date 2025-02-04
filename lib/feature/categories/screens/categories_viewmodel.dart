import 'package:flutter/cupertino.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/categories_repository.dart';
import 'package:furnihome_ar/feature/categories/model/category_model.dart';
import 'package:furnihome_ar/utils/response.dart';

class CategoriesViewModel extends ChangeNotifier {
  CategoriesRepository repository = locator<CategoriesRepository>();

  Response<List<CategoryModel>> categoryListUseCase =
      Response<List<CategoryModel>>();

  Response<List<FurnitureModel>> categoryFurnitureListUseCase =
      Response<List<FurnitureModel>>();

  void setCategoryListUseCase(Response<List<CategoryModel>> response) {
    categoryListUseCase = response;
    notifyListeners();
  }

  void setCategoryFurnitureListUseCase(
      Response<List<FurnitureModel>> response) {
    categoryFurnitureListUseCase = response;
    notifyListeners();
  }

  Future<void> getCategoryList() async {
    setCategoryListUseCase(Response.loading());
    try {
      var response = await repository.getCategoryList();
      setCategoryListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setCategoryListUseCase(Response.error(exception.toString()));
    }
  }

  Future<void> getCategoryFurnitureList(String categoryName) async {
    setCategoryFurnitureListUseCase(Response.loading());
    try {
      var response = await repository.getCategoryFurnitureList(categoryName);
      setCategoryFurnitureListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setCategoryFurnitureListUseCase(Response.error(exception.toString()));
    }
  }
}
