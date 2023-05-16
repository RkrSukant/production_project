import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/feature/search/data/remote/search_remote.dart';

class SearchRemoteImpl implements SearchRemote {
  @override
  Future<List<FurnitureModel>> getFurnitureList() async{
    List<FurnitureModel> furnitures= [

    ];
    return furnitures;
  }

}