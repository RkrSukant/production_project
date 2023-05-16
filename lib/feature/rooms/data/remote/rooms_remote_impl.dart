import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/feature/rooms/data/remote/rooms_remote.dart';
import 'package:production_project/feature/rooms/model/rooms_model.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/strings.dart';

class RoomsRemoteImpl implements RoomsRemote {

  @override
  Future<List<RoomModel>> getRoomList() async {
    List<RoomModel> items = [
      RoomModel(
          id: 1,
          title: Strings.livingRoom,
          imageName: ImageConstants.IC_SORT_BY_ROOMS_LIVING_ROOM),
      RoomModel(
          id: 1,
          title: Strings.diningRoom,
          imageName: ImageConstants.IC_SORT_BY_ROOMS_DINING_ROOM),
      RoomModel(
          id: 1,
          title: Strings.bedRoom,
          imageName: ImageConstants.IC_SORT_BY_ROOMS_BED_ROOM),
    ];
    return items;
  }

  @override
  Future<List<FurnitureModel>> getRoomFurnitureList(String roomName) async{
    return [];
  }
}
