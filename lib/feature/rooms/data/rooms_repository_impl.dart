import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/rooms/data/remote/rooms_remote.dart';
import 'package:furnihome_ar/feature/rooms/data/rooms_repository.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';

import 'local/rooms_local.dart';

class RoomsRepositoryImpl implements RoomsRepository {
  final RoomsRemote remote = locator<RoomsRemote>();
  final RoomsLocal local = locator<RoomsLocal>();

  @override
  Future<List<RoomModel>> getRoomList() async {
    return remote.getRoomList();
  }

  Future<List<FurnitureModel>> getRoomFurnitureList(String RoomName) {
    return remote.getRoomFurnitureList(RoomName);
  }
}
