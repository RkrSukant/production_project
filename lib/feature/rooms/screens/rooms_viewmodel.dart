import 'package:flutter/cupertino.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/rooms/data/rooms_repository.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';
import 'package:furnihome_ar/utils/response.dart';

class RoomsViewModel extends ChangeNotifier {
  RoomsRepository repository = locator<RoomsRepository>();

  Response<List<RoomModel>> roomListUseCase = Response<List<RoomModel>>();

  Response<List<FurnitureModel>> roomFurnitureListUseCase =
      Response<List<FurnitureModel>>();

  void setRoomListUseCase(Response<List<RoomModel>> response) {
    roomListUseCase = response;
    notifyListeners();
  }

  void setRoomFurnitureListUseCase(Response<List<FurnitureModel>> response) {
    roomFurnitureListUseCase = response;
    notifyListeners();
  }

  Future<void> getRoomList() async {
    setRoomListUseCase(Response.loading());
    try {
      var response = await repository.getRoomList();
      setRoomListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setRoomListUseCase(Response.error(exception.toString()));
    }
  }

  Future<void> getRoomFurnitureList(String roomName) async {
    setRoomFurnitureListUseCase(Response.loading());
    try {
      var response = await repository.getRoomFurnitureList(roomName);
      setRoomFurnitureListUseCase(Response.complete(response));
    } on Exception catch (exception) {
      setRoomFurnitureListUseCase(Response.error(exception.toString()));
    }
  }
}
