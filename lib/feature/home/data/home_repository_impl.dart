import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/home/data/home_repository.dart';
import 'package:production_project/feature/home/data/local/home_local.dart';
import 'package:production_project/feature/home/data/remote/home_remote.dart';
import 'package:production_project/feature/rooms/model/rooms_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemote remote = locator<HomeRemote>();
  final HomeLocal local = locator<HomeLocal>();

  @override
  Future<List<FurnitureModel>> getFeaturedProducts() async {
    return await remote.getFeaturedProducts();
  }

  @override
  Future<List<FurnitureModel>> getNewProducts() async {
    return await remote.getNewProducts();
  }

  @override
  Future<List<FurnitureModel>> getArProducts() async {
    return await remote.getArProducts();
  }

  @override
  Future<List<RoomModel>> getRoomList() async {
    return await remote.getRoomList();
  }
}
