import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/rooms/data/remote/rooms_remote.dart';
import 'package:production_project/feature/rooms/data/rooms_repository.dart';
import 'package:production_project/feature/rooms/model/rooms_model.dart';

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
