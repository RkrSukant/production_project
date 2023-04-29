import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/categories/data/categories_repository.dart';
import 'package:production_project/feature/categories/data/local/categories_local.dart';
import 'package:production_project/feature/categories/data/remote/categories_remote.dart';
import 'package:production_project/feature/categories/model/category_model.dart';

class CategoriesRepositoryImpl implements CategoriesRepository{
  final CategoriesRemote remote = locator<CategoriesRemote>();
  final CategoriesLocal local = locator<CategoriesLocal>();

  @override
  Future<List<CategoryModel>> getCategoryList() async{
    return remote.getCategoryList();
  }
  
}