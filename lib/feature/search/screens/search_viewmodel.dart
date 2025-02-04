import 'package:flutter/cupertino.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/search/data/search_repository.dart';
import 'package:furnihome_ar/utils/response.dart';

class SearchViewModel extends ChangeNotifier {
  SearchRepository repository = locator<SearchRepository>();

  Response<List<FurnitureModel>> searchListUseCase =
      Response<List<FurnitureModel>>();

  void setSearchListUseCase(Response<List<FurnitureModel>> response) {
    searchListUseCase = response;
    notifyListeners();
  }

  Future<void> getFurnitureList() async {
    setSearchListUseCase(Response.loading());
    try {
      var response = await repository.getFurnitureList();
      setSearchListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setSearchListUseCase(Response.error(exception.toString()));
    }
  }
}
