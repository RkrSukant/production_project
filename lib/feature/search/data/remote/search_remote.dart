import 'package:furnihome_ar/common_models/furniture_model.dart';

abstract class SearchRemote {
  Future<List<FurnitureModel>> getFurnitureList();
}
