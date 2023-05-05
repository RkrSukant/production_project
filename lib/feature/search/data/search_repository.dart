import 'package:production_project/common_models/furniture_model.dart';

abstract class SearchRepository{
  Future<List<FurnitureModel>> getFurnitureList();
}