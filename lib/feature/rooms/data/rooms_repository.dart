import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';

abstract class RoomsRepository {
  Future<List<RoomModel>> getRoomList();

  Future<List<FurnitureModel>> getRoomFurnitureList(String RoomName);
}
