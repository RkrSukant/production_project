import 'package:production_project/feature/categories/model/category_model.dart';

abstract class CategoriesRepository{

Future<List<CategoryModel>> getCategoryList();

}