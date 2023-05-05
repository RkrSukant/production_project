import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/search/data/local/search_local.dart';
import 'package:production_project/feature/search/data/remote/search_remote.dart';
import 'package:production_project/feature/search/data/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository{

  SearchRemote remote = locator<SearchRemote>();
  SearchLocal local = locator<SearchLocal>();

  Future<List<FurnitureModel>> getFurnitureList() async{
    return await remote.getFurnitureList();
  }
}