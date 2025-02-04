import 'package:furnihome_ar/common_models/furniture_model.dart';

abstract class SearchRepository {
  Future<List<FurnitureModel>> getFurnitureList();
}
