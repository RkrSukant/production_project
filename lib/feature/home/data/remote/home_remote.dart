import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';

abstract class HomeRemote {
  Future<List<FurnitureModel>> getFeaturedProducts();

  Future<List<FurnitureModel>> getNewProducts();

  Future<List<FurnitureModel>> getArProducts();

  Future<List<RoomModel>> getRoomList();
}
