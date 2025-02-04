import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/feature/categories/model/category_model.dart';

abstract class CategoriesRepository {
  Future<List<CategoryModel>> getCategoryList();

  Future<List<FurnitureModel>> getCategoryFurnitureList(String categoryName);
}
