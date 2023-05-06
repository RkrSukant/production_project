import 'package:flutter/cupertino.dart';
import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/search/data/search_repository.dart';
import 'package:production_project/utils/response.dart';

class SearchViewModel extends ChangeNotifier{

  SearchRepository repository = locator<SearchRepository>();

  Response<List<FurnitureModel>> searchListUseCase = Response<List<FurnitureModel>>();

  void setSearchListUseCase(Response<List<FurnitureModel>> response) {
    searchListUseCase = response;
    notifyListeners();
  }

  Future<void> getFurnitureList() async {
    setSearchListUseCase(Response.loading());
    try {
      var response = await repository.getFurnitureList();
      setSearchListUseCase(Response.complete(response));
    }on Exception catch (exception){
      setSearchListUseCase(Response.error(exception.toString()));
    }
  }
}