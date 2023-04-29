import 'package:production_project/feature/categories/model/category_model.dart';

abstract class CategoriesRemote{

  Future<List<CategoryModel>> getCategoryList();

}