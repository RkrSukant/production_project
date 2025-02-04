import 'package:flutter/foundation.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/home/data/home_repository.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';
import 'package:furnihome_ar/utils/response.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository repository = locator<HomeRepository>();

  Response<List<RoomModel>> homeRoomListUseCase = Response<List<RoomModel>>();

  Response<List<FurnitureModel>> featuredFurnitureListUseCase =
      Response<List<FurnitureModel>>();

  Response<List<FurnitureModel>> latestFurnitureListUseCase =
      Response<List<FurnitureModel>>();

  Response<List<FurnitureModel>> arFurnitureListUseCase =
      Response<List<FurnitureModel>>();

  void setHomeRoomListUseCase(Response<List<RoomModel>> response) {
    homeRoomListUseCase = response;
    notifyListeners();
  }

  void setFeaturedFurnitureListUseCase(
      Response<List<FurnitureModel>> response) {
    featuredFurnitureListUseCase = response;
    notifyListeners();
  }

  void setLatestFurnitureListUseCase(Response<List<FurnitureModel>> response) {
    latestFurnitureListUseCase = response;
    notifyListeners();
  }

  void setArFurnitureListUseCase(Response<List<FurnitureModel>> response) {
    arFurnitureListUseCase = response;
    notifyListeners();
  }

  Future<void> getRoomList() async {
    setHomeRoomListUseCase(Response.loading());
    try {
      var response = await repository.getRoomList();
      setHomeRoomListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setHomeRoomListUseCase(Response.error(exception.toString()));
    }
  }

  Future<void> getFeaturedProducts() async {
    setFeaturedFurnitureListUseCase(Response.loading());
    try {
      var response = await repository.getFeaturedProducts();
      setFeaturedFurnitureListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setFeaturedFurnitureListUseCase(Response.error(exception.toString()));
    }
  }

  Future<void> getLatestProducts() async {
    setLatestFurnitureListUseCase(Response.loading());
    try {
      var response = await repository.getNewProducts();
      setLatestFurnitureListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setLatestFurnitureListUseCase(Response.error(exception.toString()));
    }
  }

  Future<void> getArProducts() async {
    setArFurnitureListUseCase(Response.loading());
    try {
      var response = await repository.getArProducts();
      setArFurnitureListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setArFurnitureListUseCase(Response.error(exception.toString()));
    }
  }
}
