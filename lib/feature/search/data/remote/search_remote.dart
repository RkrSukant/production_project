import 'package:production_project/common_models/furniture_model.dart';

abstract class SearchRemote{
  Future<List<FurnitureModel>> getFurnitureList();
}