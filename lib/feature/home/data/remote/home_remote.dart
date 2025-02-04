import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/feature/rooms/model/rooms_model.dart';

abstract class HomeRemote {
  Future<List<FurnitureModel>> getFeaturedProducts();

  Future<List<FurnitureModel>> getNewProducts();

  Future<List<FurnitureModel>> getArProducts();

  Future<List<RoomModel>> getRoomList();
}
