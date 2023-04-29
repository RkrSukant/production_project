import 'package:flutter/cupertino.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/categories/data/categories_repository.dart';
import 'package:production_project/feature/categories/model/category_model.dart';
import 'package:production_project/utils/response.dart';

class CategoriesViewModel extends ChangeNotifier{
  CategoriesRepository repository = locator<CategoriesRepository>();

  Response<List<CategoryModel>> categoryListUseCase = Response<List<CategoryModel>>();

  void setCategoryListUseCase(Response<List<CategoryModel>> response) {
    categoryListUseCase = response;
    notifyListeners();
  }

  Future<void> getCategoryList() async{
    setCategoryListUseCase(Response.loading());
    try{
      var response = await repository.getCategoryList();
      setCategoryListUseCase(Response.complete(response));
    }on Exception catch (exception){
      setCategoryListUseCase(Response.error(exception.toString()));
    }
  }
}