import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/feature/rooms/model/rooms_model.dart';

abstract class RoomsRemote{

  Future<List<RoomModel>> getRoomList();

  Future<List<FurnitureModel>> getRoomFurnitureList(String RoomName);
}