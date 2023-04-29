import 'package:production_project/feature/categories/data/remote/categories_remote.dart';
import 'package:production_project/feature/categories/model/category_model.dart';
import 'package:production_project/utils/image_constants.dart';

class CategoriesRemoteImpl implements CategoriesRemote{
  @override
  Future<List<CategoryModel>> getCategoryList() async{
    List<CategoryModel> items = [
      CategoryModel(id: 1, categoryName: "Sofa", imageName: ImageConstants.IC_CATEGORY_SOFA),
      CategoryModel(id: 2, categoryName: "Chair", imageName: ImageConstants.IC_CATEGORY_CHAIRS),
      CategoryModel(id: 3, categoryName: "Desk Chair", imageName: ImageConstants.IC_CATEGORY_DESK_CHAIR),
      CategoryModel(id: 4, categoryName: "Desk", imageName: ImageConstants.IC_CATEGORY_DESK),
      CategoryModel(id: 5, categoryName: "Coffee Table", imageName: ImageConstants.IC_CATEGORY_COFFEE_TABLE),
      CategoryModel(id: 6, categoryName: "Side Table", imageName: ImageConstants.IC_CATEGORY_SIDE_TABLE),
    ];
    return items;
  }

}