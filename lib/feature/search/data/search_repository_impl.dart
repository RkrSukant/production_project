import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/search/data/local/search_local.dart';
import 'package:furnihome_ar/feature/search/data/remote/search_remote.dart';
import 'package:furnihome_ar/feature/search/data/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRemote remote = locator<SearchRemote>();
  SearchLocal local = locator<SearchLocal>();

  @override
  Future<List<FurnitureModel>> getFurnitureList() async {
    return await remote.getFurnitureList();
  }
}
